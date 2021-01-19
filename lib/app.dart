import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubit/cubits.dart';
import 'core/repository/repositories_provider.dart';
import 'core/store/store.dart';
import 'main.dart';
import 'page/pages.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: getRepositoryProviders(
        context.watch<Store>(),
      ),
      child: BlocProvider<NotificationCubit>(
        create: (_) => NotificationCubit(FirebaseMessaging()),
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
