import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/entity/model/route_model.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import '../../../mocks.dart';

void main() {
  RouteCubit cubit;
  MockRouteRepository mockRouteRepository;
  MockGlobalInfo mockGlobalInfo;
  MockNotificationCubit mockNotificationCubit;

  group('InitialSettingsCubit', () {
    setUpAll(() {
      mockRouteRepository = MockRouteRepository();
      mockGlobalInfo = MockGlobalInfo();
      mockNotificationCubit = MockNotificationCubit();
    });

    setUp(() {
      cubit = RouteCubit(
        route: RouteModel(),
        repository: mockRouteRepository,
        globalInfo: mockGlobalInfo,
        notificationCubit: mockNotificationCubit,
      );
    });

    test('asserts', () {
      expect(
          () => RouteCubit(
                route: null,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
              ),
          throwsAssertionError);
      expect(
          () => RouteCubit(
                route: RouteModel(),
                repository: null,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
              ),
          throwsAssertionError);
      expect(
          () => RouteCubit(
                route: RouteModel(),
                repository: mockRouteRepository,
                globalInfo: null,
                notificationCubit: mockNotificationCubit,
              ),
          throwsAssertionError);

      expect(
          () => RouteCubit(
                route: RouteModel(),
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: null,
              ),
          throwsAssertionError);
    });

    test('initial state is RouteInitial', () {
      expect(cubit.state is RouteInitial, true);
    });
  });
}
