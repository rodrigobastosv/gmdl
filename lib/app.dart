import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/repository/repositories_provider.dart';
import 'core/store/store_provider.dart';
import 'main.dart';
import 'page/pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: getRepositoryProviders(
        context.watch<StoreProvider>(),
      ),
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
    );
  }
}
