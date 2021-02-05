import 'package:flutter/services.dart';

void setupPluginsForTesting() {
  const pathProviderChannel = MethodChannel('plugins.flutter.io/path_provider');
  pathProviderChannel.setMockMethodCallHandler((_) async => ".");
  const deviceInfoChannel = MethodChannel('plugins.flutter.io/device_info');
  deviceInfoChannel.setMockMethodCallHandler((_) async => {});
  const packageInfoChannel = MethodChannel('plugins.flutter.io/package_info');
  packageInfoChannel.setMockMethodCallHandler((_) async => {});
}
