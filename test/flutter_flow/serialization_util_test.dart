import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/flutter_flow/lat_lng.dart';
import 'package:orange_a_i_hub/flutter_flow/nav/serialization_util.dart';

void main() {
  group('serializeParam / deserializeParam round trips', () {
    // These helpers are used every time the app passes data between pages
    // through the router, so a bug here silently breaks navigation.

    test('null serializes to null', () {
      expect(serializeParam(null, ParamType.int), isNull);
      expect(deserializeParam(null, ParamType.int, false), isNull);
    });

    test('int round trip', () {
      final s = serializeParam(42, ParamType.int);
      expect(deserializeParam<int>(s, ParamType.int, false), 42);
    });

    test('double round trip', () {
      final s = serializeParam(3.14, ParamType.double);
      expect(deserializeParam<double>(s, ParamType.double, false), 3.14);
    });

    test('String round trip', () {
      final s = serializeParam('hello', ParamType.String);
      expect(deserializeParam<String>(s, ParamType.String, false), 'hello');
    });

    test('bool round trip', () {
      expect(
        deserializeParam<bool>(
            serializeParam(true, ParamType.bool), ParamType.bool, false),
        isTrue,
      );
      expect(
        deserializeParam<bool>(
            serializeParam(false, ParamType.bool), ParamType.bool, false),
        isFalse,
      );
    });

    test('local DateTime round trip preserves the exact moment', () {
      final now = DateTime.now();
      final s = serializeParam(now, ParamType.DateTime);
      final restored =
          deserializeParam<DateTime>(s, ParamType.DateTime, false) as DateTime;
      expect(restored.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
      expect(restored.isUtc, isFalse);
    });

    test('UTC DateTime round trip stays UTC', () {
      final utc = DateTime.utc(2026, 7, 18, 12, 30);
      final s = serializeParam(utc, ParamType.DateTime);
      final restored =
          deserializeParam<DateTime>(s, ParamType.DateTime, false) as DateTime;
      expect(restored.isUtc, isTrue);
      expect(restored, utc);
    });

    test('DateTimeRange round trip', () {
      final range = DateTimeRange(
        start: DateTime(2026, 1, 1),
        end: DateTime(2026, 12, 31),
      );
      final s = serializeParam(range, ParamType.DateTimeRange);
      final restored = deserializeParam<DateTimeRange>(
          s, ParamType.DateTimeRange, false) as DateTimeRange;
      expect(restored.start, range.start);
      expect(restored.end, range.end);
    });

    test('LatLng round trip', () {
      const point = LatLng(37.4219983, -122.084);
      final s = serializeParam(point, ParamType.LatLng);
      expect(deserializeParam<LatLng>(s, ParamType.LatLng, false), point);
    });

    test('Color round trip', () {
      const color = Color(0xFF3F51B5);
      final s = serializeParam(color, ParamType.Color);
      final restored =
          deserializeParam<Color>(s, ParamType.Color, false) as Color;
      expect(restored, color);
    });

    test('JSON map round trip', () {
      final jsonValue = {
        'model': 'gemini-1.5-pro',
        'tokens': 128,
        'streaming': true
      };
      final s = serializeParam(jsonValue, ParamType.JSON);
      expect(deserializeParam(s, ParamType.JSON, false), jsonValue);
    });

    test('list of ints round trip', () {
      final s = serializeParam([1, 2, 3], ParamType.int, isList: true);
      expect(deserializeParam<int>(s, ParamType.int, true), [1, 2, 3]);
    });

    test('list of strings round trip', () {
      final s =
          serializeParam(['a', 'b'], ParamType.String, isList: true);
      expect(deserializeParam<String>(s, ParamType.String, true), ['a', 'b']);
    });
  });

  group('deserialization of malformed input', () {
    // Bad data must return null, never crash the router.

    test('non-numeric int returns null', () {
      expect(deserializeParam<int>('abc', ParamType.int, false), isNull);
    });

    test('dateTimeFromString handles empty and garbage input', () {
      expect(dateTimeFromString(''), isNull);
      expect(dateTimeFromString(null), isNull);
      expect(dateTimeFromString('uNOT_A_NUMBER'), isNull);
    });

    test('dateTimeRangeFromString rejects input without separator', () {
      expect(dateTimeRangeFromString('123456'), isNull);
    });

    test('latLngFromString rejects malformed coordinates', () {
      expect(latLngFromString('37.42'), isNull);
      expect(latLngFromString(null), isNull);
    });

    test('invalid JSON returns null instead of throwing', () {
      expect(deserializeParam('{not json', ParamType.JSON, false), isNull);
    });

    test('empty or non-list JSON for a list param returns null', () {
      expect(deserializeParam<int>('[]', ParamType.int, true), isNull);
      expect(deserializeParam<int>('"str"', ParamType.int, true), isNull);
    });
  });
}
