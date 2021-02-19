import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info/package_info.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';
import 'package:gm_driver_lite/core/repository/repositories.dart';
import 'package:gm_driver_lite/core/service/services.dart';

// Cubit
class MockInitialSettingsCubit extends MockBloc<InitialSettingsState>
    implements InitialSettingsCubit {}

class MockLoadInfoCubit extends MockBloc<LoadInfoState>
    implements LoadInfoCubit {}

class MockChooseEquipmentCubit extends MockBloc<ChooseEquipmentState>
    implements ChooseEquipmentCubit {}

class MockChooseCancelCodeCubit extends MockBloc<ChooseCancelCodeState>
    implements ChooseCancelCodeCubit {}

class MockChooseRedeliverCodeCubit extends MockBloc<ChooseRedeliverCodeState>
    implements ChooseRedeliverCodeCubit {}

class MockChooseUndeliverableCodeCubit
    extends MockBloc<ChooseUndeliverableCodeState>
    implements ChooseUndeliverableCodeCubit {}

class MockLoadRouteCubit extends MockBloc<LoadRouteState>
    implements LoadRouteCubit {}

class MockI18nCubit extends MockBloc<I18nState> implements I18nCubit {}

class MockRouteCubit extends MockBloc<RouteState> implements RouteCubit {}

class MockSignInCubit extends MockBloc<SignInState> implements SignInCubit {}

class MockStopCubit extends MockBloc<StopState> implements StopCubit {}

class MockNotificationCubit extends MockBloc<NotificationState>
    implements NotificationCubit {}

class MockHosCubit extends MockBloc<HosState> implements HosCubit {}

class MockGpsCubit extends MockBloc<GpsState> implements GpsCubit {}

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

class MockGpsRepository extends Mock implements GpsRepository {}

class MockHosRepository extends Mock implements HosRepository {}

// Services
class MockDeviceInfoService extends Mock implements DeviceInfoService {}

class MockPackageInfoService extends Mock implements PackageInfoService {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockLaunchService extends Mock implements LaunchService {}

class MockGpsService extends Mock implements GpsService {}

// General
class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockPackageInfo extends Mock implements PackageInfo {}

class MockConnectivity extends Mock implements Connectivity {}

class MockBox extends Mock implements Box {}

class MockGlobalInfo extends Mock implements GlobalInfo {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
