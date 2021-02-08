import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/utils/general/crypt_utils.dart';

void main() {
  group('Crypt Utils', () {
    test(
      '''WHEN encodeString is called
         SHOULD encode the given string on base64
      ''',
      () {
        final encodedString = encodeString('12345');
        expect(encodedString, 'MTIzNDU=');
      },
    );

    test(
      '''WHEN decodeString is called
         SHOULD decode the given encoded string
      ''',
      () {
        final encodedString = encodeString('12345');
        final decodedString = decodeString(encodedString);
        expect(decodedString, '12345');
      },
    );
  });
}
