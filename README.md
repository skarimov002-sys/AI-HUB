# AI-HUB (Orange AI Hub)

A Flutter app, built with [FlutterFlow](https://flutterflow.io), for chatting
with and comparing AI models (Gemini, and others via API). Includes Firebase
auth, analytics, and Cloud Functions.

## Project layout

- `lib/` — the Flutter app source code
  - `lib/pages/` — the app's screens (chat, model comparison, settings, …)
  - `lib/components/` — reusable UI pieces (chat bubble, model card, …)
  - `lib/backend/gemini/` — calls to the Gemini API
  - `lib/flutter_flow/` — FlutterFlow's utility/framework layer
- `test/` — unit tests (run with `flutter test`)
- `firebase/` — Firebase config, security rules, and Cloud Functions
- `flutterflow/` — FlutterFlow project configuration YAMLs (for reference)

## Running the app

```sh
flutter pub get
flutter run
```

## AI providers and API keys

The app supports three AI providers: **Gemini**, **GPT (OpenAI)**, and
**Claude (Anthropic)**. All requests are routed through a Firebase Cloud
Function (`firebase/functions/ai_providers.js`), so API keys live only on
the server — never inside the app.

To configure keys:

1. Copy `firebase/functions/.env.example` to `firebase/functions/.env`
2. Fill in the keys you have (leave the others empty)
3. Deploy: `firebase deploy --only functions`

Providers without a key automatically appear as **"coming soon"** in the
app's model selector. Once you add a key and redeploy, that provider's chip
lights up — no app update needed.

Never commit an API key to the repository (`.env` is gitignored).

## Running the tests

```sh
flutter test
```
