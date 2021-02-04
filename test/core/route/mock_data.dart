import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/cubit/stop/stop_cubit.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';
import 'package:gm_driver_lite/core/repository/client/gm_client.dart';
import 'package:gm_driver_lite/core/repository/repositories.dart';
import 'package:gm_driver_lite/page/stop/stop_page_arguments.dart';

final routeCubit = RouteCubit(
  repository: RouteRepository(GMClient()),
  route: RouteModel(),
  globalInfo: GlobalInfo(),
  notificationCubit: notificationCubit,
);

final stopCubit = StopCubit(
  stop: StopModel(),
  repository: StopRepository(GMClient()),
  routeCubit: routeCubit,
  globalInfo: GlobalInfo(),
);

final notificationCubit = NotificationCubit(
  globalInfo: GlobalInfo(),
  firebaseMessaging: FirebaseMessaging.instance,
  repository: NotificationRepository(GMClient()),
);

final stopPageArguments = StopPageArguments(
  stop: StopModel(),
  routeCubit: routeCubit,
);
