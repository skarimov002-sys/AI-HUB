import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/backend/speech/speech_input.dart';

void main() {
  group('SpeechInput.bestLocaleId', () {
    test('finds the Uzbek locale on a device that has it', () {
      expect(
        SpeechInput.bestLocaleId(['en_US', 'ru_RU', 'uz_UZ'], 'uz'),
        'uz_UZ',
      );
    });

    test('finds the Russian locale on a device that has it', () {
      expect(
        SpeechInput.bestLocaleId(['en_US', 'ru_RU', 'uz_UZ'], 'ru'),
        'ru_RU',
      );
    });

    test('matches dash-separated locale ids too', () {
      expect(
        SpeechInput.bestLocaleId(['en-US', 'uz-UZ'], 'uz'),
        'uz-UZ',
      );
    });

    test('matches a bare language code', () {
      expect(SpeechInput.bestLocaleId(['ru'], 'ru'), 'ru');
    });

    test('is case-insensitive', () {
      expect(SpeechInput.bestLocaleId(['UZ_UZ'], 'uz'), 'UZ_UZ');
    });

    test('returns null when the language is not on the device', () {
      expect(SpeechInput.bestLocaleId(['en_US', 'fr_FR'], 'uz'), isNull);
      expect(SpeechInput.bestLocaleId([], 'ru'), isNull);
    });

    test('does not match a different language with the same prefix letters',
        () {
      // 'ru' must not match 'rup_XX' style ids — only 'ru' or 'ru_*'.
      expect(SpeechInput.bestLocaleId(['rup_MK'], 'ru'), isNull);
    });
  });
}
