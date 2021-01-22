import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubit/cubits.dart';
import 'core/extension/i18n_cubit_extension.dart';
import 'core/repository/repositories.dart';
import 'core/repository/repositories_provider.dart';
import 'core/store/store.dart';
import 'main.dart';
import 'page/pages.dart';
import 'widget/alert/notification.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: getRepositoryProviders(
        context.watch<Store>(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotificationCubit>(
            create: (innerContext) => NotificationCubit(
              firebaseMessaging: FirebaseMessaging.instance,
              repository: innerContext.read<NotificationRepository>(),
              store: context.read<Store>(),
            )..initNotifications(),
          ),
          BlocProvider<ConnectivityCubit>(
            create: (_) => ConnectivityCubit(
              connectivity: Connectivity(),
            )..intiConnectionListener(),
          ),
          BlocProvider<I18nCubit>(
            create: (innerContext) => I18nCubit(
              innerContext.read<I18nRepository>(),
            ),
          ),
        ],
        child: BlocListener<ConnectivityCubit, ConnectivityState>(
          listener: (contextListener, state) {
            if (state is HasConnection) {
              if (state.hasConnection) {
                showSuccessNotification(
                    contextListener.getText('loader.server.connected'));
              } else {
                showErrorNotification(
                    contextListener.getText('loader.server.unreachable'));
              }
            }
          },
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
      ),
    );
  }
}
