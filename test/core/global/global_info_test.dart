import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';

void main() {
  group('GlobalInfo', () {
    test(
      '''WHEN storeGeneralInfo
         SHOULD set the values
      ''',
      () {
        final driverInfo = DriverInfoDto();
        final mobileDevice = MobileDeviceDto();
        final globalConfigurations = GlobalConfigurationsDto();
        final userConfigurations = <String, dynamic>{};
        final cancelCodes = <CancelCodeModel>[];
        final undeliverableCodes = <UndeliverableCodeModel>[];

        final globalInfo = GlobalInfo();
        globalInfo.storeGeneralInfo(
          driverInfo: driverInfo,
          mobileDevice: mobileDevice,
          globalConfigurations: globalConfigurations,
          userConfigurations: userConfigurations,
          cancelCodes: cancelCodes,
          undeliverableCodes: undeliverableCodes,
        );

        expect(globalInfo.driverInfo, driverInfo);
        expect(globalInfo.mobileDevice, mobileDevice);
        expect(globalInfo.globalConfigurations, globalConfigurations);
        expect(globalInfo.userConfigurations, userConfigurations);
        expect(globalInfo.cancelCodes, cancelCodes);
        expect(globalInfo.undeliverableCodes, undeliverableCodes);
      },
    );
  });
}
