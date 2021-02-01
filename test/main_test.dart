import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/main.dart' as app;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const pathProviderChannel = MethodChannel('plugins.flutter.io/path_provider');
  pathProviderChannel.setMockMethodCallHandler((_) async => ".");
  const deviceInfoChannel = MethodChannel('plugins.flutter.io/device_info');
  deviceInfoChannel.setMockMethodCallHandler((_) async => {});
  const packageInfoChannel = MethodChannel('plugins.flutter.io/package_info');
  packageInfoChannel.setMockMethodCallHandler((_) async => {});

  test('should run main', () async {
    await app.main();
  });
}
