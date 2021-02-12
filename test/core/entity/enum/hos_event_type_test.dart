import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('HosEventType', () {
    test('hosEventTypeToJson', () {
      expect(hosEventTypeToJson(HosEventType.LUNCH_START), 'LUNCH_START');
      expect(hosEventTypeToJson(HosEventType.LUNCH_END), 'LUNCH_END');
    });
  });
}
