import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/backend/ai_providers/ai_providers.dart';

void main() {
  group('aiProviderFromId', () {
    test('maps known ids to providers', () {
      expect(aiProviderFromId('gemini'), AiProvider.gemini);
      expect(aiProviderFromId('gpt'), AiProvider.gpt);
      expect(aiProviderFromId('claude'), AiProvider.claude);
    });

    test('returns null for unknown or null ids', () {
      expect(aiProviderFromId('llama'), isNull);
      expect(aiProviderFromId(''), isNull);
      expect(aiProviderFromId(null), isNull);
    });
  });

  group('providersFromResponse', () {
    test('parses a normal server response', () {
      final data = {
        'providers': {'gemini': true, 'gpt': false, 'claude': false},
      };
      expect(providersFromResponse(data), {AiProvider.gemini});
    });

    test('includes every provider whose flag is true', () {
      final data = {
        'providers': {'gemini': true, 'gpt': true, 'claude': true},
      };
      expect(
        providersFromResponse(data),
        {AiProvider.gemini, AiProvider.gpt, AiProvider.claude},
      );
    });

    test('ignores unknown providers in the response', () {
      final data = {
        'providers': {'gemini': true, 'llama': true},
      };
      expect(providersFromResponse(data), {AiProvider.gemini});
    });

    test('treats non-boolean values as unavailable', () {
      final data = {
        'providers': {'gemini': 'yes', 'gpt': 1, 'claude': null},
      };
      expect(providersFromResponse(data), isEmpty);
    });

    test('malformed data yields an empty set instead of throwing', () {
      expect(providersFromResponse(null), isEmpty);
      expect(providersFromResponse('garbage'), isEmpty);
      expect(providersFromResponse({}), isEmpty);
      expect(providersFromResponse({'providers': 'oops'}), isEmpty);
      expect(providersFromResponse([1, 2, 3]), isEmpty);
    });
  });

  group('AiProvider display names', () {
    test('match what the model selector shows', () {
      expect(AiProvider.gemini.displayName, 'Gemini');
      expect(AiProvider.gpt.displayName, 'GPT-4o');
      expect(AiProvider.claude.displayName, 'Claude');
    });
  });
}
