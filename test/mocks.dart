import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';
import 'package:gm_driver_lite/core/repository/repositories.dart';
import 'package:gm_driver_lite/core/service/services.dart';
import 'package:package_info/package_info.dart';

// Cubit
class MockI18nCubit extends MockBloc<I18nState> implements I18nCubit {}

class MockRouteCubit extends MockBloc<RouteState> implements RouteCubit {}

class MockNotificationCubit extends MockBloc<NotificationState>
    implements NotificationCubit {}

// Repository
class MockEquipmentRepository extends Mock implements EquipmentRepository {}

class MockI18nRepository extends Mock implements I18nRepository {}

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

class MockInitialSettingsRepository extends Mock
    implements InitialSettingsRepository {}

class MockLoadingInfoRepository extends Mock implements LoadingInfoRepository {}

class MockRouteRepository extends Mock implements RouteRepository {}

class MockSignInRepository extends Mock implements SignInRepository {}

class MockStopRepository extends Mock implements StopRepository {}

// Services
class MockDeviceInfoService extends Mock implements DeviceInfoService {}

class MockPackageInfoService extends Mock implements PackageInfoService {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

// General
class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockPackageInfo extends Mock implements PackageInfo {}

class MockConnectivity extends Mock implements Connectivity {}

class MockBox extends Mock implements Box {}

class MockGlobalInfo extends Mock implements GlobalInfo {}
