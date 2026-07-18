const functions = require("firebase-functions");
const axios = require("axios").default;

// Server-side AI provider routing.
//
// API keys are read from environment variables and NEVER shipped inside the
// app. Locally, put them in firebase/functions/.env (see .env.example);
// that file is gitignored and gets deployed with `firebase deploy`.
//
// A provider whose key is missing is reported as unavailable, which the app
// shows as "coming soon" in the model selector.

const PROVIDERS = {
  gemini: {
    displayName: "Gemini",
    envKey: "GEMINI_API_KEY",
    generate: callGemini,
  },
  gpt: {
    displayName: "GPT (OpenAI)",
    envKey: "OPENAI_API_KEY",
    generate: callOpenAi,
  },
  claude: {
    displayName: "Claude (Anthropic)",
    envKey: "ANTHROPIC_API_KEY",
    generate: callClaude,
  },
};

function apiKeyFor(providerId) {
  const key = process.env[PROVIDERS[providerId].envKey];
  return key && key.trim() !== "" ? key : null;
}

// --- Provider API calls -----------------------------------------------------

async function callGemini(apiKey, { prompt, imageBase64, imageMimeType, imageUrl, countTokens }) {
  const model = imageBase64 || imageUrl ? "gemini-1.5-flash" : "gemini-1.5-pro";
  const parts = [{ text: prompt }];

  if (imageUrl && !imageBase64) {
    // Download the image server-side and inline it as base64.
    const image = await axios.get(imageUrl, { responseType: "arraybuffer" });
    imageBase64 = Buffer.from(image.data).toString("base64");
    imageMimeType = imageMimeType || image.headers["content-type"] || "image/jpeg";
  }
  if (imageBase64) {
    parts.push({
      inline_data: { mime_type: imageMimeType || "image/jpeg", data: imageBase64 },
    });
  }

  const action = countTokens ? "countTokens" : "generateContent";
  const url =
    `https://generativelanguage.googleapis.com/v1beta/models/${model}:${action}?key=${apiKey}`;
  const response = await axios.post(url, { contents: [{ parts: parts }] });

  if (countTokens) {
    return String(response.data.totalTokens);
  }
  const candidate = response.data.candidates && response.data.candidates[0];
  if (!candidate || !candidate.content || !candidate.content.parts) {
    return null;
  }
  return candidate.content.parts.map((p) => p.text || "").join("");
}

async function callOpenAi(apiKey, { prompt }) {
  const response = await axios.post(
    "https://api.openai.com/v1/chat/completions",
    {
      model: "gpt-4o",
      messages: [{ role: "user", content: prompt }],
    },
    { headers: { Authorization: `Bearer ${apiKey}` } },
  );
  const choice = response.data.choices && response.data.choices[0];
  return choice ? choice.message.content : null;
}

async function callClaude(apiKey, { prompt }) {
  const response = await axios.post(
    "https://api.anthropic.com/v1/messages",
    {
      model: "claude-sonnet-4-5",
      max_tokens: 1024,
      messages: [{ role: "user", content: prompt }],
    },
    {
      headers: {
        "x-api-key": apiKey,
        "anthropic-version": "2023-06-01",
      },
    },
  );
  const content = response.data.content || [];
  return content.map((block) => block.text || "").join("");
}

// --- Callable functions (what the Flutter app talks to) ---------------------

// Returns which providers have a key configured, e.g.
// { providers: { gemini: true, gpt: false, claude: false } }
const listAiProviders = functions.https.onCall(async (_data, _context) => {
  const providers = {};
  for (const providerId of Object.keys(PROVIDERS)) {
    providers[providerId] = apiKeyFor(providerId) !== null;
  }
  return { providers: providers };
});

// Runs one generation request against the requested provider.
// data: { provider, prompt, imageBase64?, imageMimeType?, imageUrl?, countTokens? }
const aiGenerate = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be signed in to use the AI chat.",
    );
  }

  const provider = PROVIDERS[data.provider];
  if (!provider) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      `Unknown AI provider "${data.provider}".`,
    );
  }
  if (typeof data.prompt !== "string" || data.prompt.trim() === "") {
    throw new functions.https.HttpsError("invalid-argument", "Prompt must not be empty.");
  }

  const apiKey = apiKeyFor(data.provider);
  if (!apiKey) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      `${provider.displayName} is coming soon — its API key has not been configured yet.`,
    );
  }

  try {
    const text = await provider.generate(apiKey, data);
    return { text: text };
  } catch (error) {
    // Never leak the raw provider response (it can echo request headers).
    const status = error.response ? error.response.status : null;
    console.error(`${data.provider} request failed`, status, error.message);
    throw new functions.https.HttpsError(
      "internal",
      status
        ? `${provider.displayName} request failed with status ${status}.`
        : `${provider.displayName} request failed: ${error.message}`,
    );
  }
});

module.exports = { listAiProviders, aiGenerate };
