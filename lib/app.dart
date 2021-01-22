import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import 'global_cubits_widget_provider.dart';
import 'main.dart';
import 'page/pages.dart';
import 'repositories_widget_provider.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoriesWidgetProvider(
      child: GlobalCubitsWidgetProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: alice.getNavigatorKey(),
          title: 'Flutter Demo',
          builder: BotToastInit(),
          theme: ThemeData(
            primaryColor: const Color(0xFF3AA348),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const InitialSettingsPage(),
        ),
      ),
    );
  }
}
