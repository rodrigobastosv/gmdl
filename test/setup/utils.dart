import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/driver_info_dto.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import 'package:gm_driver_lite/core/entity/dto/mobile_device_dto.dart';
import 'package:gm_driver_lite/core/global/global_info.dart';
import 'package:gm_driver_lite/core/route/route.dart';
import 'package:gm_driver_lite/global_cubits_widget_provider.dart';
import 'package:gm_driver_lite/page/pages.dart';
import 'package:gm_driver_lite/repositories_widget_provider.dart';
import 'package:gm_driver_lite/widget/global_info_widget_provider.dart';

import '../mocks.dart';
import 'setups.dart';

Future<void> setupForWidgetTesting() async {
  setupPluginsForTesting();
  await setupWidgetsForTesting();
  await setupFirebaseForTesting();
  await Firebase.initializeApp();
}

Widget connectedWidgetForTesting({
  @required Widget child,
  MockNavigatorObserver mockNavigatorObserver,
}) {
  assert(child != null);

  return RepositoriesWidgetProvider(
    child: GlobalInfoWidgetProvider(
      child: GlobalCubitsWidgetProvider(
        child: MaterialApp(
          home: child,
          navigatorObservers: [
            mockNavigatorObserver ?? MockNavigatorObserver(),
          ],
          onGenerateRoute: generateTestRoutes,
        ),
      ),
      globalInfo: GlobalInfo()
        ..storeGeneralInfo(
          driverInfo: DriverInfoDto(
            id: 1,
            login: 'driver',
            name: 'driver',
          ),
          mobileDevice: MobileDeviceDto(
            id: 1,
          ),
          globalConfigurations: GlobalConfigurationsDto(
            id: 1,
          ),
          userConfigurations: {},
          cancelCodes: [],
          undeliverableCodes: [],
        ),
    ),
  );
}

Route<dynamic> generateTestRoutes(RouteSettings settings) {
  final routeName = settings.name;

  Widget routeWidget;
  switch (routeName) {
    case INITIAL_SETTINGS_PAGE:
      routeWidget = BlocProvider<InitialSettingsCubit>(
        create: (_) => MockInitialSettingsCubit(),
        child: InitialSettingsPage(),
      );
      break;
    case LOAD_INFO_PAGE:
      routeWidget = BlocProvider(
        create: (context) => MockLoadInfoCubit(),
        child: const LoadInfoPage(),
      );
      break;
    case CHOOSE_EQUIPMENT_PAGE:
      routeWidget = BlocProvider<ChooseEquipmentCubit>(
        create: (context) => MockChooseEquipmentCubit(),
        child: ChooseEquipmentPage(),
      );
      break;
    case LOAD_ROUTE_PAGE:
      routeWidget = BlocProvider<LoadRouteCubit>(
        create: (context) => MockLoadRouteCubit(),
        child: const LoadRoutePage(),
      );
      break;
    case ROUTE_AT_GLANCE_PAGE:
      routeWidget = BlocProvider<RouteCubit>(
        create: (context) => MockRouteCubit(),
        child: const RouteAtGlancePage(),
      );
      break;
    case ROUTE_SUMMARY_PAGE:
      routeWidget = BlocProvider.value(
        value: MockRouteCubit(),
        child: const RouteSummaryPage(),
      );
      break;
    case SIGN_IN_PAGE:
      routeWidget = BlocProvider(
        create: (context) => MockSignInCubit(),
        child: SignInPage(),
      );
      break;
    case STOP_PAGE:
      routeWidget = MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MockStopCubit(),
          ),
          BlocProvider(
            create: (context) => MockRouteCubit(),
          ),
        ],
        child: const StopPage(),
      );
      break;
    case CHOOSE_CANCEL_CODE_PAGE:
      routeWidget = MultiBlocProvider(
        providers: [
          BlocProvider.value(value: MockStopCubit()),
          BlocProvider(
            create: (_) => MockChooseCancelCodeCubit(),
          ),
        ],
        child: const ChooseCancelCodePage(),
      );
      break;
    case CHOOSE_REDELIVER_CODE_PAGE:
      routeWidget = MultiBlocProvider(
        providers: [
          BlocProvider.value(value: MockStopCubit()),
          BlocProvider(
            create: (_) => MockChooseRedeliverCodeCubit(),
          ),
        ],
        child: const ChooseRedeliverCodePage(),
      );
      break;
    case CHOOSE_UNDELIVERABLE_CODE_PAGE:
      routeWidget = MultiBlocProvider(
        providers: [
          BlocProvider.value(value: MockStopCubit()),
          BlocProvider(
            create: (_) => MockChooseUndeliverableCodeCubit(),
          ),
        ],
        child: const ChooseUndeliverableCodePage(),
      );
      break;
    case STOP_LIST_PAGE:
      routeWidget = BlocProvider.value(
        value: MockRouteCubit(),
        child: const StopListPage(),
      );
      break;
    case FINISHED_STOPS_PAGE:
      routeWidget = BlocProvider.value(
        value: MockRouteCubit(),
        child: const FinishedStopsPage(
          stops: [],
        ),
      );
      break;
    default:
      routeWidget = Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      );
  }
  return CupertinoPageRoute(
    builder: (context) => routeWidget,
    settings: settings,
  );
}
