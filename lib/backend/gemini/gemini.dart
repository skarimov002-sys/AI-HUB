// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'dart:convert';

import 'package:flutter/material.dart';

import '/backend/ai_providers/ai_providers.dart';
import '/flutter_flow/flutter_flow_util.dart';

// All Gemini requests are routed through the `aiGenerate` Firebase Cloud
// Function (see firebase/functions/ai_providers.js), so no API key ever
// ships inside the app.

Future<String?> geminiGenerateText(
  BuildContext context,
  String prompt,
) =>
    aiGenerateText(context, AiProvider.gemini, prompt);

Future<String?> geminiCountTokens(
  BuildContext context,
  String prompt,
) =>
    aiGenerateText(context, AiProvider.gemini, prompt, countTokens: true);

Future<String?> geminiTextFromImage(
  BuildContext context,
  String prompt, {
  String? imageNetworkUrl = '',
  FFUploadedFile? uploadImageBytes,
}) {
  assert(
    imageNetworkUrl != null || uploadImageBytes != null,
    'Either imageNetworkUrl or uploadImageBytes must be provided.',
  );

  return aiGenerateText(
    context,
    AiProvider.gemini,
    prompt,
    imageBase64: uploadImageBytes?.bytes != null
        ? base64Encode(uploadImageBytes!.bytes!)
        : null,
    imageUrl: uploadImageBytes == null ? imageNetworkUrl : null,
  );
}
