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
import 'route.dart';

class GMRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;

    switch (routeName) {
      case INITIAL_SETTINGS_PAGE:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<InitialSettingsCubit>(
            create: (_) => InitialSettingsCubit(
              repository: InitialSettingsRepository(
                GMClient(getBasicClient()),
              ),
              globalBox: Hive.box(GLOBAL_BOX),
            ),
            child: InitialSettingsPage(),
          ),
          settings: settings,
        );
      case LOAD_INFO_PAGE:
        final username = args as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => LoadInfoCubit(
              repository: context.read<LoadingInfoRepository>(),
              globalInfo: context.read<GlobalInfo>(),
              i18nCubit: context.read<I18nCubit>(),
              deviceInfoService: G<DeviceInfoService>(),
              packageInfoService: G<PackageInfoService>(),
            )..getDriverInfo(username),
            child: const LoadInfoPage(),
          ),
          settings: settings,
        );
      case CHOOSE_EQUIPMENT_PAGE:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChooseEquipmentCubit>(
            create: (_) => ChooseEquipmentCubit(
              context.read<EquipmentRepository>(),
            ),
            child: ChooseEquipmentPage(),
          ),
          settings: settings,
        );
      case LOAD_ROUTE_PAGE:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoadRouteCubit>(
            create: (_) => LoadRouteCubit(
              repository: context.read<RouteRepository>(),
              globalInfo: context.read<GlobalInfo>(),
              i18nCubit: context.read<I18nCubit>(),
            )..fetchRouteInformation(),
            child: const LoadRoutePage(),
          ),
          settings: settings,
        );
      case ROUTE_AT_GLANCE_PAGE:
        final route = args as RouteModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RouteCubit>(
            create: (_) => RouteCubit(
              route: route,
              repository: context.read<RouteRepository>(),
              globalInfo: context.read<GlobalInfo>(),
              notificationCubit: context.read<NotificationCubit>(),
            )..listenNotifications(),
            child: const RouteAtGlancePage(),
          ),
          settings: settings,
        );
      case ROUTE_SUMMARY_PAGE:
        final routeCubit = args as RouteCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: routeCubit,
            child: const RouteSummaryPage(),
          ),
          settings: settings,
        );
      case SIGN_IN_PAGE:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => SignInCubit(
              repository: context.read<SignInRepository>(),
              globalBox: Hive.box(GLOBAL_BOX),
            ),
            child: SignInPage(),
          ),
          settings: settings,
        );
      case STOP_PAGE:
        final stopPageArguments = args as StopPageArguments;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => StopCubit(
                  stop: stopPageArguments.stop,
                  routeCubit: stopPageArguments.routeCubit,
                  repository: context.read<StopRepository>(),
                  globalInfo: context.read<GlobalInfo>(),
                ),
              ),
              BlocProvider.value(value: stopPageArguments.routeCubit),
            ],
            child: const StopPage(),
          ),
          settings: settings,
        );
      case CHOOSE_CANCEL_CODE_PAGE:
        final stopCubit = args as StopCubit;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: stopCubit),
              BlocProvider(
                create: (_) => ChooseCancelCodeCubit(),
              ),
            ],
            child: const ChooseCancelCodePage(),
          ),
          settings: settings,
        );
      case CHOOSE_REDELIVER_CODE_PAGE:
        final stopCubit = args as StopCubit;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: stopCubit),
              BlocProvider(
                create: (_) => ChooseRedeliverCodeCubit(),
              ),
            ],
            child: const ChooseRedeliverCodePage(),
          ),
          settings: settings,
        );
      case CHOOSE_UNDELIVERABLE_CODE_PAGE:
        final stopCubit = args as StopCubit;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: stopCubit),
              BlocProvider(
                create: (_) => ChooseUndeliverableCodeCubit(),
              ),
            ],
            child: const ChooseUndeliverableCodePage(),
          ),
          settings: settings,
        );
      case STOP_LIST_PAGE:
        final routeCubit = args as RouteCubit;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: routeCubit,
            child: const StopListPage(),
          ),
          settings: settings,
        );
      case FINISHED_STOPS_PAGE:
        final routeCubit = args as RouteCubit;
        final stops = routeCubit.route.stops;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: routeCubit,
            child: FinishedStopsPage(
              stops: stops,
            ),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
