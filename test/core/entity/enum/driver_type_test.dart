import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/entity/enum/enums.dart';

void main() {
  group('DriverType', () {
    test('driverTypeToJson', () {
      expect(driverTypeToJson(DriverType.DEFAULT), 'DEFAULT');
      expect(driverTypeToJson(DriverType.HELPER), 'HELPER');
    });

    test('driverTypeFromJson', () {
      expect(driverTypeFromJson('DEFAULT'), DriverType.DEFAULT);
      expect(driverTypeFromJson('HELPER'), DriverType.HELPER);
      expect(driverTypeFromJson(''), DriverType.DEFAULT);
    });
  });
}
