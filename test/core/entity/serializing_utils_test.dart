import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/serializing_utils.dart';

void main() {
  group('convertToDouble', () {
    test(
      '''WHEN the value is double 
         SHOULD return the same double value
      ''',
      () {
        final doubleValue = 5.0;
        final convertedValue = convertToDouble(doubleValue);
        expect(convertedValue, doubleValue);
        expect(convertedValue is double, true);
      },
    );

    test(
      '''WHEN the value is int
         AND the value is not null
         SHOULD return the int converted to double 
      ''',
      () {
        final intValue = 5;
        final convertedValue = convertToDouble(intValue);
        expect(convertedValue, intValue.toDouble());
        expect(convertedValue is double, true);
      },
    );

    test(
      '''WHEN the value is int
         AND the value is null
         SHOULD return the double value 0.0
      ''',
      () {
        final convertedValue = convertToDouble(null);
        expect(convertedValue, 0.0);
        expect(convertedValue is double, true);
      },
    );
  });
}
