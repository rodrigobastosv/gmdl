import 'package:flutter/material.dart';

import 'package:package_info/package_info.dart';

import '../../core/route/route.dart';
import '../../main.dart';
import 'global_info_widget_provider.dart';
import 'dependencies_widget_provider.dart';
import 'global_cubits_listeners.dart';
import 'global_cubits_widget_provider.dart';
import 'repositories_widget_provider.dart';

final navigatorKey = alice.getNavigatorKey();

class GMApp extends StatelessWidget {
  const GMApp({
    Key key,
    @required PackageInfo packageInfo,
  })  : assert(packageInfo != null),
        _packageInfo = packageInfo,
        super(key: key);

  final PackageInfo _packageInfo;

  @override
  Widget build(BuildContext context) {
    return DependenciesWidgetProvider(
      packageInfo: _packageInfo,
      child: RepositoriesWidgetProvider(
        child: GlobalInfoWidgetProvider(
          child: GlobalCubitsWidgetProvider(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: const Color(0xFF3AA348),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              builder: (context, child) => GlobalCubitsListeners(
                child: child,
              ),
              onGenerateRoute: GMRouter.generateRoutes,
            ),
          ),
        ),
      ),
    );
  }
}
