import 'package:flutter/material.dart';

import 'core/route/gm_router.dart';
import 'global_cubits_widget_provider.dart';
import 'main.dart';
import 'repositories_widget_provider.dart';
import 'widget/global_info_widget_provider.dart';

class GMApp extends StatelessWidget {
  const GMApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoriesWidgetProvider(
      child: GlobalInfoWidgetProvider(
        child: GlobalCubitsWidgetProvider(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: alice.getNavigatorKey(),
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: const Color(0xFF3AA348),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: GMRouter.generateRoutes,
          ),
        ),
      ),
    );
  }
}
