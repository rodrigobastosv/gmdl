import 'package:flutter/material.dart';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../../core/repository/client/gm_client.dart';
import '../../core/service/services.dart';

class DependenciesWidgetProvider extends StatelessWidget {
  const DependenciesWidgetProvider({
    Key key,
    @required PackageInfo packageInfo,
    @required Widget child,
  })  : assert(packageInfo != null),
        assert(child != null),
        _packageInfo = packageInfo,
        _child = child,
        super(key: key);

  final PackageInfo _packageInfo;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GMClient>(
          create: (_) => GMClient(),
        ),
        Provider<LaunchService>(
          create: (_) => LaunchService(),
        ),
        Provider<GpsService>(
          create: (_) => GpsService(),
        ),
        Provider<DeviceInfoService>(
          create: (_) => DeviceInfoService(DeviceInfoPlugin())..init(),
        ),
        Provider<PackageInfoService>(
          create: (_) => PackageInfoService(_packageInfo),
        ),
      ],
      child: _child,
    );
  }
}
