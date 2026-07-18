import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/flutter_flow/lat_lng.dart';

void main() {
  group('LatLng', () {
    test('two instances with the same coordinates are equal', () {
      expect(const LatLng(37.42, -122.08), const LatLng(37.42, -122.08));
      expect(
        const LatLng(37.42, -122.08).hashCode,
        const LatLng(37.42, -122.08).hashCode,
      );
    });

    test('instances with different coordinates are not equal', () {
      expect(const LatLng(37.42, -122.08), isNot(const LatLng(0, 0)));
    });

    test('serialize produces "lat,lng"', () {
      expect(const LatLng(37.42, -122.08).serialize(), '37.42,-122.08');
    });

    test('toString is human readable', () {
      expect(
        const LatLng(1.5, 2.5).toString(),
        'LatLng(lat: 1.5, lng: 2.5)',
      );
    });
  });
}
