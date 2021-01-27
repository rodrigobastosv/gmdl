import 'package:device_info/device_info.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';

import 'services.dart';

final G = GetIt.I;

Future<void> initServices() async {
  G.registerSingleton<DeviceInfoService>(
      DeviceInfoService(DeviceInfoPlugin())..init());

  final _packageInfo = await PackageInfo.fromPlatform();
  G.registerSingleton<PackageInfoService>(PackageInfoService(_packageInfo));
}
