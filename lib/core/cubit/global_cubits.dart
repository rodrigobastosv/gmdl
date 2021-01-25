import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../global/global_info.dart';
import '../global/hive.dart';
import '../repository/repositories.dart';
import 'cubits.dart';

List<BlocProvider> getGlobalCubits(BuildContext context) => [
      BlocProvider<NotificationCubit>(
        create: (innerContext) => NotificationCubit(
          firebaseMessaging: FirebaseMessaging.instance,
          repository: innerContext.read<NotificationRepository>(),
          globalInfo: context.read<GlobalInfo>(),
        )..initNotifications(),
      ),
      BlocProvider<ConnectivityCubit>(
        create: (_) => ConnectivityCubit(
          connectivity: Connectivity(),
        )..intiConnectionListener(),
      ),
      BlocProvider<I18nCubit>(
        create: (innerContext) => I18nCubit(
          repository: innerContext.read<I18nRepository>(),
        )..initResources(Hive.box(CONFIG_BOX)),
      ),
    ];
