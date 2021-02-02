import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../page/pages.dart';
import '../../page/stop/stop_page_arguments.dart';
import '../cubit/cubits.dart';
import '../cubit/stop/stop_cubit.dart';
import '../entity/model/models.dart';
import '../global/global_info.dart';
import '../global/hive.dart';
import '../repository/client/client.dart';
import '../repository/client/gm_client.dart';
import '../repository/repositories.dart';
import '../service/services.dart';
import '../service/services_locator.dart';
import '../utils/platform_utils.dart';
import 'route.dart';

class GMRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;

    Widget routeWidget;
    switch (routeName) {
      case INITIAL_SETTINGS_PAGE:
        routeWidget = BlocProvider<InitialSettingsCubit>(
          create: (_) => InitialSettingsCubit(
            repository: InitialSettingsRepository(
              GMClient(getBasicClient()),
            ),
            globalBox: Hive.box(GLOBAL_BOX),
          ),
          child: InitialSettingsPage(),
        );
        break;
      case LOAD_INFO_PAGE:
        final username = args as String;
        routeWidget = BlocProvider(
          create: (context) => LoadInfoCubit(
            repository: context.read<LoadingInfoRepository>(),
            globalInfo: context.read<GlobalInfo>(),
            i18nCubit: context.read<I18nCubit>(),
            deviceInfoService: G<DeviceInfoService>(),
            packageInfoService: G<PackageInfoService>(),
          )..getDriverInfo(username),
          child: const LoadInfoPage(),
        );
        break;
      case CHOOSE_EQUIPMENT_PAGE:
        routeWidget = BlocProvider<ChooseEquipmentCubit>(
          create: (context) => ChooseEquipmentCubit(
            context.read<EquipmentRepository>(),
          ),
          child: ChooseEquipmentPage(),
        );
        break;
      case LOAD_ROUTE_PAGE:
        routeWidget = BlocProvider<LoadRouteCubit>(
          create: (context) => LoadRouteCubit(
            repository: context.read<RouteRepository>(),
            globalInfo: context.read<GlobalInfo>(),
            i18nCubit: context.read<I18nCubit>(),
          )..fetchRouteInformation(),
          child: const LoadRoutePage(),
        );
        break;
      case ROUTE_AT_GLANCE_PAGE:
        final route = args as RouteModel;
        routeWidget = BlocProvider<RouteCubit>(
          create: (context) => RouteCubit(
            route: route,
            repository: context.read<RouteRepository>(),
            globalInfo: context.read<GlobalInfo>(),
            notificationCubit: context.read<NotificationCubit>(),
          )..listenNotifications(),
          child: const RouteAtGlancePage(),
        );
        break;
      case ROUTE_SUMMARY_PAGE:
        final routeCubit = args as RouteCubit;
        routeWidget = BlocProvider.value(
          value: routeCubit,
          child: const RouteSummaryPage(),
        );
        break;
      case SIGN_IN_PAGE:
        routeWidget = BlocProvider(
          create: (context) => SignInCubit(
            repository: context.read<SignInRepository>(),
            globalBox: Hive.box(GLOBAL_BOX),
          ),
          child: SignInPage(),
        );
        break;
      case STOP_PAGE:
        final stopPageArguments = args as StopPageArguments;
        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => StopCubit(
                stop: stopPageArguments.stop,
                routeCubit: stopPageArguments.routeCubit,
                repository: context.read<StopRepository>(),
                globalInfo: context.read<GlobalInfo>(),
              ),
            ),
            BlocProvider.value(value: stopPageArguments.routeCubit),
          ],
          child: const StopPage(),
        );
        break;
      case CHOOSE_CANCEL_CODE_PAGE:
        final stopCubit = args as StopCubit;
        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider.value(value: stopCubit),
            BlocProvider(
              create: (_) => ChooseCancelCodeCubit(),
            ),
          ],
          child: const ChooseCancelCodePage(),
        );
        break;
      case CHOOSE_REDELIVER_CODE_PAGE:
        final stopCubit = args as StopCubit;
        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider.value(value: stopCubit),
            BlocProvider(
              create: (_) => ChooseRedeliverCodeCubit(),
            ),
          ],
          child: const ChooseRedeliverCodePage(),
        );
        break;
      case CHOOSE_UNDELIVERABLE_CODE_PAGE:
        final stopCubit = args as StopCubit;
        routeWidget = MultiBlocProvider(
          providers: [
            BlocProvider.value(value: stopCubit),
            BlocProvider(
              create: (_) => ChooseUndeliverableCodeCubit(),
            ),
          ],
          child: const ChooseUndeliverableCodePage(),
        );
        break;
      case STOP_LIST_PAGE:
        final routeCubit = args as RouteCubit;
        routeWidget = BlocProvider.value(
          value: routeCubit,
          child: const StopListPage(),
        );
        break;
      case FINISHED_STOPS_PAGE:
        final routeCubit = args as RouteCubit;
        final stops = routeCubit.route.stops;
        routeWidget = BlocProvider.value(
          value: routeCubit,
          child: FinishedStopsPage(
            stops: stops,
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
    return isAndroid()
        ? MaterialPageRoute(
            builder: (context) => routeWidget,
            settings: settings,
          )
        : CupertinoPageRoute(
            builder: (context) => routeWidget,
            settings: settings,
          );
  }
}
