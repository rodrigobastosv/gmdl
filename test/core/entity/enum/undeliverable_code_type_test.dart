import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('UndeliverableCodeType', () {
    test('undeliverableCodeTypeToJson', () {
      expect(
          undeliverableCodeTypeToJson(UndeliverableCodeType.BACK_LATTER), 'L');
      expect(undeliverableCodeTypeToJson(UndeliverableCodeType.UNSUCCESSFULL),
          'U');
      expect(undeliverableCodeTypeToJson(UndeliverableCodeType.BOTH), 'B');
    });

    test('undeliverableCodeTypeFromJson', () {
      expect(undeliverableCodeTypeFromJson('L'),
          UndeliverableCodeType.BACK_LATTER);
      expect(undeliverableCodeTypeFromJson('U'),
          UndeliverableCodeType.UNSUCCESSFULL);
      expect(undeliverableCodeTypeFromJson('B'), UndeliverableCodeType.BOTH);
    });
  });
}
