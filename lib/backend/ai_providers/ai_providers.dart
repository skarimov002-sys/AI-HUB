// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// The AI providers the app supports. All requests are routed through the
/// `aiGenerate` Firebase Cloud Function so API keys stay server-side only.
enum AiProvider {
  gemini('gemini', 'Gemini'),
  gpt('gpt', 'GPT-4o'),
  claude('claude', 'Claude');

  const AiProvider(this.id, this.displayName);

  /// The identifier shared with the Cloud Function.
  final String id;

  /// The name shown in the UI.
  final String displayName;
}

AiProvider? aiProviderFromId(String? id) =>
    AiProvider.values.firstWhereOrNull((p) => p.id == id);

/// Parses the `listAiProviders` Cloud Function response, e.g.
/// `{providers: {gemini: true, gpt: false, claude: false}}`, into the set of
/// providers that have an API key configured. Malformed data yields an
/// empty set rather than an error.
Set<AiProvider> providersFromResponse(dynamic data) {
  if (data is! Map) {
    return {};
  }
  final providers = data['providers'];
  if (providers is! Map) {
    return {};
  }
  return AiProvider.values.where((p) => providers[p.id] == true).toSet();
}

/// Asks the server which providers are ready to use. Providers without a
/// configured key are shown as "coming soon" in the model selector.
Future<Set<AiProvider>> fetchAvailableProviders() async {
  try {
    final result = await FirebaseFunctions.instance
        .httpsCallable('listAiProviders')
        .call();
    return providersFromResponse(result.data);
  } catch (_) {
    // If the function can't be reached, fall back to Gemini only — the one
    // provider expected to have a key.
    return {AiProvider.gemini};
  }
}

/// Sends a prompt to [provider] via the `aiGenerate` Cloud Function and
/// returns the generated text, or null after showing an error snackbar.
Future<String?> aiGenerateText(
  BuildContext context,
  AiProvider provider,
  String prompt, {
  String? imageBase64,
  String? imageMimeType,
  String? imageUrl,
  bool countTokens = false,
}) async {
  try {
    final result =
        await FirebaseFunctions.instance.httpsCallable('aiGenerate').call({
      'provider': provider.id,
      'prompt': prompt,
      if (imageBase64 != null) 'imageBase64': imageBase64,
      if (imageMimeType != null) 'imageMimeType': imageMimeType,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (countTokens) 'countTokens': true,
    });
    return (result.data as Map)['text'] as String?;
  } on FirebaseFunctionsException catch (e) {
    if (context.mounted) {
      showSnackbar(context, e.message ?? 'AI request failed.');
    }
    return null;
  } catch (e) {
    if (context.mounted) {
      showSnackbar(context, 'AI request failed: $e');
    }
    return null;
  }
}
