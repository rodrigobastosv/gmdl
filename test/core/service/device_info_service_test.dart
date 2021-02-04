import 'package:device_info/device_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/service/services.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  DeviceInfoService deviceInfoService;
  MockDeviceInfoPlugin mockDeviceInfoPlugin;

  group('DeviceInfoService test', () {
    setUp(() {
      mockDeviceInfoPlugin = MockDeviceInfoPlugin();
      deviceInfoService = DeviceInfoService(mockDeviceInfoPlugin);
    });

    test('init', () {
      deviceInfoService.init();
    });

    test('getId', () async {
      when(mockDeviceInfoPlugin.iosInfo).thenAnswer(
        (_) async => IosDeviceInfo(identifierForVendor: 'identifierForVendor'),
      );
      await deviceInfoService.init();
      
      final id = deviceInfoService.getId();
      expect(id, 'identifierForVendor');
    });
  });
}
