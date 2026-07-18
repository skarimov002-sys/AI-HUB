import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/flutter_flow/flutter_flow_util.dart';

void main() {
  group('valueOrDefault', () {
    test('returns the default for null', () {
      expect(valueOrDefault<int?>(null, 7), 7);
    });

    test('returns the default for an empty string', () {
      expect(valueOrDefault('', 'fallback'), 'fallback');
    });

    test('returns the value when present', () {
      expect(valueOrDefault('actual', 'fallback'), 'actual');
      expect(valueOrDefault<int?>(0, 7), 0);
    });
  });

  group('dateTimeFormat', () {
    test('null date returns an empty string', () {
      expect(dateTimeFormat('yMd', null), '');
    });

    test('formats a fixed date with a pattern', () {
      expect(dateTimeFormat('d/M/y', DateTime(2026, 7, 18)), '18/7/2026');
    });

    test('relative format describes how long ago', () {
      final fiveMinutesAgo =
          DateTime.now().subtract(const Duration(minutes: 5));
      expect(dateTimeFormat('relative', fiveMinutesAgo), '5 minutes ago');
    });
  });

  group('formatNumber', () {
    test('decimal with automatic separators', () {
      expect(
        formatNumber(1234567,
            formatType: FormatType.decimal,
            decimalType: DecimalType.automatic),
        '1,234,567',
      );
    });

    test('period decimal with a currency symbol', () {
      expect(
        formatNumber(1234.5,
            formatType: FormatType.decimal,
            decimalType: DecimalType.periodDecimal,
            currency: '€'),
        '€1,234.50',
      );
    });

    test('percent', () {
      expect(formatNumber(0.5, formatType: FormatType.percent), '50%');
    });

    test('compact', () {
      expect(formatNumber(1500, formatType: FormatType.compact), '1.5K');
    });

    test('custom pattern', () {
      expect(
        formatNumber(3.5, formatType: FormatType.custom, format: '00.00'),
        '03.50',
      );
    });

    test('null value returns an empty string', () {
      expect(formatNumber(null, formatType: FormatType.percent), '');
    });
  });

  group('castToType', () {
    test('int stored value casts to double', () {
      expect(castToType<double>(3), 3.0);
    });

    test('whole double stored value casts to int', () {
      expect(castToType<int>(3.0), 3);
    });

    test('null stays null', () {
      expect(castToType<int>(null), isNull);
    });
  });

  group('getJsonField', () {
    final response = {
      'model': {'name': 'gemini-1.5-pro', 'tokens': 128},
      'messages': [
        {'text': 'hi'},
        {'text': 'hello'},
      ],
    };

    test('reads a nested field', () {
      expect(getJsonField(response, r'$.model.name'), 'gemini-1.5-pro');
    });

    test('missing field returns null', () {
      expect(getJsonField(response, r'$.model.missing'), isNull);
    });

    test('multiple matches are returned as a list', () {
      expect(
          getJsonField(response, r'$.messages[*].text'), ['hi', 'hello']);
    });

    test('isForList wraps a single value in a list', () {
      expect(
          getJsonField(response, r'$.model.name', true), ['gemini-1.5-pro']);
    });
  });

  group('string extensions', () {
    test('maybeHandleOverflow truncates with a replacement', () {
      expect(
        'hello world'.maybeHandleOverflow(maxChars: 5, replacement: '…'),
        'hello…',
      );
    });

    test('maybeHandleOverflow leaves short strings alone', () {
      expect('hi'.maybeHandleOverflow(maxChars: 5), 'hi');
    });

    test('toCapitalization capitalizes each word', () {
      expect(
        'orange ai hub'.toCapitalization(TextCapitalization.words),
        'Orange Ai Hub',
      );
    });

    test('toCapitalization sentences capitalizes the first letter', () {
      expect(
        'hello there'.toCapitalization(TextCapitalization.sentences),
        'Hello there',
      );
    });
  });

  group('collection extensions', () {
    test('withoutNulls removes null entries from a list', () {
      expect([1, null, 2, null, 3].withoutNulls, [1, 2, 3]);
    });

    test('withoutNulls removes null values from a map', () {
      expect(
        {'a': 1, 'b': null, 'c': 3}.withoutNulls,
        {'a': 1, 'c': 3},
      );
    });

    test('unique keeps the first occurrence of each key', () {
      expect(
        ['apple', 'avocado', 'banana'].unique((s) => s[0]),
        ['apple', 'banana'],
      );
    });

    test('sortedList sorts by key ascending and descending', () {
      final words = ['ccc', 'a', 'bb'];
      expect(words.sortedList(keyOf: (w) => w.length), ['a', 'bb', 'ccc']);
      expect(
        words.sortedList(keyOf: (w) => w.length, desc: true),
        ['ccc', 'bb', 'a'],
      );
    });
  });

  group('colorFromCssString', () {
    test('parses a valid css color', () {
      expect(colorFromCssString('rgb(255,0,0)'), const Color(0xFFFF0000));
    });

    test('falls back to black for garbage input', () {
      expect(colorFromCssString('not-a-color'), Colors.black);
    });

    test('honors an explicit default color', () {
      expect(
        colorFromCssString('not-a-color', defaultColor: Colors.blue),
        Colors.blue,
      );
    });
  });

  group('date helpers', () {
    test('seconds since epoch round trip', () {
      final dt = DateTime.fromMillisecondsSinceEpoch(1750000000000);
      expect(
        dateTimeFromSecondsSinceEpoch(dt.secondsSinceEpoch),
        dt,
      );
    });

    test('comparison operators', () {
      final earlier = DateTime(2026, 1, 1);
      final later = DateTime(2026, 12, 31);
      expect(earlier < later, isTrue);
      expect(later > earlier, isTrue);
      expect(earlier <= DateTime(2026, 1, 1), isTrue);
      expect(earlier >= later, isFalse);
    });
  });

  group('validators', () {
    final emailRegex = RegExp(kTextValidatorEmailRegex);

    test('accepts normal email addresses', () {
      expect(emailRegex.hasMatch('user@example.com'), isTrue);
      expect(emailRegex.hasMatch('first.last+tag@sub.domain.org'), isTrue);
    });

    test('rejects malformed email addresses', () {
      expect(emailRegex.hasMatch('not-an-email'), isFalse);
      expect(emailRegex.hasMatch('missing@tld@double.com'), isFalse);
    });
  });

  group('math helpers', () {
    test('roundTo limits decimal places', () {
      expect(roundTo(3.14159, 2), '3.14');
      expect(roundTo(2.5, 0), '3.0');
    });
  });
}
