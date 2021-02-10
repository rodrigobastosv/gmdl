import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';
import 'package:gm_driver_lite/core/repository/client/gm_client.dart';
import 'package:gm_driver_lite/core/repository/repositories.dart';
import 'package:gm_driver_lite/core/service/services.dart';
import 'package:gm_driver_lite/page/stop/stop_page_arguments.dart';

final routeCubit = RouteCubit(
  repository: RouteRepository(GMClient()),
  route: RouteModel(),
  globalInfo: GlobalInfo(),
  notificationCubit: notificationCubit,
  clientCubit: clientCubit,
  gpsCubit: gpsCubit,
  launchService: LaunchService(),
);

final hosCubit = HosCubit(
  repository: HosRepository(GMClient()),
  globalInfo: GlobalInfo(),
);

final stopCubit = StopCubit(
  stop: StopModel(),
  repository: StopRepository(GMClient()),
  routeCubit: routeCubit,
  gpsCubit: gpsCubit,
  globalInfo: GlobalInfo(),
  clientCubit: clientCubit,
);

final clientCubit = ClientCubit();

final gpsCubit = GpsCubit(
  repository: GpsRepository(GMClient()),
  gpsService: GpsService(),
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
