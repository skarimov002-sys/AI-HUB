// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Thin wrapper around the speech_to_text plugin so the UI only deals with
/// "start listening, give me text" and language selection.
class SpeechInput {
  final SpeechToText _speech = SpeechToText();
  bool _initialized = false;
  List<String> _availableLocaleIds = [];

  bool get isListening => _speech.isListening;

  /// Initializes the device's speech recognizer (asks for microphone
  /// permission the first time). Returns false when speech recognition is
  /// not available on this device.
  Future<bool> init({void Function(String status)? onStatus}) async {
    if (_initialized) {
      return true;
    }
    _initialized = await _speech.initialize(
      onStatus: (status) => onStatus?.call(status),
      onError: (_) => onStatus?.call('error'),
    );
    if (_initialized) {
      final locales = await _speech.locales();
      _availableLocaleIds = locales.map((l) => l.localeId).toList();
    }
    return _initialized;
  }

  /// Picks the device locale id that best matches [languageCode]
  /// (e.g. 'uz' -> 'uz_UZ'). Returns null when the language isn't
  /// supported by the device, letting the caller fall back gracefully.
  static String? bestLocaleId(
    List<String> availableLocaleIds,
    String languageCode,
  ) {
    final wanted = languageCode.toLowerCase();
    for (final id in availableLocaleIds) {
      final normalized = id.toLowerCase().replaceAll('-', '_');
      if (normalized == wanted || normalized.startsWith('${wanted}_')) {
        return id;
      }
    }
    return null;
  }

  /// Starts listening in [languageCode] ('uz' or 'ru') and reports the
  /// recognized sentence so far through [onText] as the user speaks.
  /// Returns false when the requested language isn't available.
  Future<bool> start(
    String languageCode,
    void Function(String recognizedText) onText,
  ) async {
    final localeId = bestLocaleId(_availableLocaleIds, languageCode);
    if (localeId == null) {
      return false;
    }
    await _speech.listen(
      localeId: localeId,
      onResult: (SpeechRecognitionResult result) =>
          onText(result.recognizedWords),
      listenOptions: SpeechListenOptions(partialResults: true),
    );
    return true;
  }

  Future<void> stop() => _speech.stop();
}
