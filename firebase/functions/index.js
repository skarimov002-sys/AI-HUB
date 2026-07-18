const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const aiProviders = require("./ai_providers");
exports.listAiProviders = aiProviders.listAiProviders;
exports.aiGenerate = aiProviders.aiGenerate;
