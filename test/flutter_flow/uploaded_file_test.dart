import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/flutter_flow/uploaded_file.dart';

void main() {
  group('FFUploadedFile serialization', () {
    test('serialize -> deserialize round trip preserves all fields', () {
      final original = FFUploadedFile(
        name: 'photo.jpg',
        bytes: Uint8List.fromList([1, 2, 3, 255]),
        height: 100.0,
        width: 200.0,
        blurHash: 'LEHV6nWB2yk8',
        originalFilename: 'IMG_0001.jpg',
      );

      final restored = FFUploadedFile.deserialize(original.serialize());

      expect(restored.name, 'photo.jpg');
      // Bytes are compared element-by-element: the round trip creates a new
      // list object, so identity comparison would not work here.
      expect(restored.bytes, orderedEquals([1, 2, 3, 255]));
      expect(restored.height, 100.0);
      expect(restored.width, 200.0);
      expect(restored.blurHash, 'LEHV6nWB2yk8');
      expect(restored.originalFilename, 'IMG_0001.jpg');
    });

    test('deserialize fills sensible defaults for missing fields', () {
      final restored = FFUploadedFile.deserialize('{}');

      expect(restored.name, '');
      expect(restored.bytes, isEmpty);
      expect(restored.height, isNull);
      expect(restored.width, isNull);
      expect(restored.blurHash, isNull);
      expect(restored.originalFilename, '');
    });
  });
}
