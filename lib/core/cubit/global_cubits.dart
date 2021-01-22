import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/repositories.dart';
import '../store/store.dart';
import 'cubits.dart';

List<BlocProvider> getGlobalCubits(BuildContext context) => [
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
        )..initResources(context.read<Store>()),
      ),
    ];
