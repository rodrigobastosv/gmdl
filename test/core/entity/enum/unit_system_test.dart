import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('UnitSystem', () {
    test('unitSystemToJson', () {
      expect(unitSystemToJson(UnitSystem.METRIC), 'METRIC');
      expect(unitSystemToJson(UnitSystem.NON_METRIC), 'NON_METRIC');
      expect(unitSystemToJson(null), 'METRIC');
    });

    test('unitSystemFromJson', () {
      expect(unitSystemFromJson('METRIC'), UnitSystem.METRIC);
      expect(unitSystemFromJson('NON_METRIC'), UnitSystem.NON_METRIC);
      expect(unitSystemFromJson(''), UnitSystem.NON_METRIC);
    });
  });
}
