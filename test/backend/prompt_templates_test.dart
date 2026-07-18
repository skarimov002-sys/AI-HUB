import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/backend/prompt_templates.dart';

void main() {
  group('promptTemplates', () {
    test('contains the five expected Uzbek templates', () {
      expect(
        promptTemplates.map((t) => t.title),
        [
          'Referat yozish',
          'Matnni tarjima qilish',
          'Matnni tuzatish',
          'Insho yozish',
          'Savolga javob',
        ],
      );
    });

    test('every starter prompt is non-empty and ends with ": " so the user '
        'can continue the sentence', () {
      for (final template in promptTemplates) {
        expect(template.starterPrompt, isNotEmpty);
        expect(
          template.starterPrompt.endsWith(': '),
          isTrue,
          reason: '"${template.title}" starter prompt should invite the user '
              'to finish it',
        );
      }
    });

    test('titles are unique', () {
      final titles = promptTemplates.map((t) => t.title).toSet();
      expect(titles.length, promptTemplates.length);
    });

    test('every template has a description', () {
      for (final template in promptTemplates) {
        expect(template.description, isNotEmpty);
      }
    });
  });
}
