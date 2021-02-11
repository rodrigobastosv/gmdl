import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/cubits.dart';
import '../../core/global/global_info.dart';
import '../../core/global/hive.dart';
import '../../core/repository/repositories.dart';
import '../../core/service/services.dart';
import 'connectivity_listener.dart';

class GlobalCubitsWidgetProvider extends StatelessWidget {
  const GlobalCubitsWidgetProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClientCubit>(
          create: (_) => ClientCubit()..init(),
          lazy: false,
        ),
        BlocProvider<GpsCubit>(
          create: (_) => GpsCubit(
            repository: context.read<GpsRepository>(),
            gpsService: context.read<GpsService>(),
          )..initPositionTracking(),
        ),
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
            globalBox: Hive.box(GLOBAL_BOX),
          )..initI18nInfo(),
        ),
        BlocProvider<HosCubit>(
          create: (_) => HosCubit(
            repository: context.read<HosRepository>(),
            globalInfo: context.read<GlobalInfo>(),
          ),
          lazy: false,
        ),
      ],
      child: ConnectivityListener(child: child),
    );
  }
}
