import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/entity/model/route_model.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:mockito/mockito.dart';
import '../../../mocks.dart';

void main() {
  RouteCubit cubit;
  MockRouteRepository mockRouteRepository;
  MockGlobalInfo mockGlobalInfo;
  MockNotificationCubit mockNotificationCubit;

  RouteModel route;

  group('InitialSettingsCubit', () {
    setUpAll(() {
      mockRouteRepository = MockRouteRepository();
      mockGlobalInfo = MockGlobalInfo();
      mockNotificationCubit = MockNotificationCubit();
    });

    setUp(() {
      route = RouteModel(
        id: 1,
      );
      cubit = RouteCubit(
        route: route,
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
                route: route,
                repository: null,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
              ),
          throwsAssertionError);
      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: null,
                notificationCubit: mockNotificationCubit,
              ),
          throwsAssertionError);

      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: null,
              ),
          throwsAssertionError);
    });

    test('initial state is RouteInitial', () {
      expect(cubit.state is RouteInitial, true);
    });

    group('startRoute', () {
      blocTest(
        '''WHEN startRoute is called
           SHOULD emit StartingRoute and RouteStartedSuccess
        ''',
        build: () {
          when(mockRouteRepository.startRoute(route.id))
              .thenAnswer((_) => Future.value());
          when(mockRouteRepository.fetchProConfig(route.id))
              .thenAnswer((_) async => null);
          return cubit;
        },
        act: (cubit) => cubit.startRoute(),
        expect: [
          StartingRoute(),
          RouteStartedSuccess(),
        ],
      );

      test('should change route status after route started', () async {
        when(mockRouteRepository.startRoute(route.id))
            .thenAnswer((_) => Future.value());
        when(mockRouteRepository.fetchProConfig(route.id))
            .thenAnswer((_) async => null);

        expect(cubit.route.status == RouteStatus.STARTED, false);
        await cubit.startRoute();
        expect(cubit.route.status == RouteStatus.STARTED, true);
      });

      blocTest(
        '''WHEN startRoute is called and has PRO config
           SHOULD emit StartingRoute, ProConfigAppliedToRoute, RouteStartedSuccess
        ''',
        build: () {
          when(mockRouteRepository.startRoute(route.id))
              .thenAnswer((_) => Future.value());
          when(mockRouteRepository.fetchProConfig(route.id))
              .thenAnswer((_) async => ProactiveRouteOptConfigModel());
          return cubit;
        },
        act: (cubit) => cubit.startRoute(),
        expect: [
          StartingRoute(),
          ProConfigAppliedToRoute(ProactiveRouteOptConfigModel()),
          RouteStartedSuccess(),
        ],
      );

      test('should apply pro config to route when has config', () async {
        when(mockRouteRepository.startRoute(route.id))
            .thenAnswer((_) => Future.value());
        when(mockRouteRepository.fetchProConfig(route.id))
            .thenAnswer((_) async => ProactiveRouteOptConfigModel());

        expect(cubit.route.isUsingPro, false);
        await cubit.startRoute();
        expect(cubit.route.isUsingPro, true);
      });

      blocTest(
        '''WHEN startRoute throws Exception
           SHOULD emit StartingRoute and RouteStartFailed
        ''',
        build: () {
          when(mockRouteRepository.startRoute(route.id))
              .thenThrow(StartRouteException('error'));
          return cubit;
        },
        act: (cubit) => cubit.startRoute(),
        expect: [
          StartingRoute(),
          RouteStartFailed('error'),
        ],
      );
    });

    group('departOrigin', () {
      blocTest(
        '''WHEN departOrigin is called
           SHOULD emit DepartingOrigin and DepartOriginSuccess
        ''',
        build: () {
          when(mockRouteRepository.departOrigin(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.departOrigin(),
        expect: [
          DepartingOrigin(),
          DepartOriginSuccess(),
        ],
      );

      test('should change route status after route departed', () async {
        when(mockRouteRepository.departOrigin(route.id))
            .thenAnswer((_) => Future.value());

        expect(cubit.route.status == RouteStatus.DEPARTED_ORIGIN, false);
        await cubit.departOrigin();
        expect(cubit.route.status == RouteStatus.DEPARTED_ORIGIN, true);
      });

      blocTest(
        '''WHEN departOrigin is called
           SHOULD emit DepartingOrigin and DepartOriginSuccess
        ''',
        build: () {
          when(mockRouteRepository.departOrigin(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.departOrigin(),
        expect: [
          DepartingOrigin(),
          DepartOriginSuccess(),
        ],
      );

      blocTest(
        '''WHEN departOrigin throws Exception
           SHOULD emit DepartingOrigin and DepartOriginFailed
        ''',
        build: () {
          when(mockRouteRepository.departOrigin(route.id))
              .thenThrow(Exception());
          return cubit;
        },
        act: (cubit) => cubit.departOrigin(),
        expect: [
          DepartingOrigin(),
          DepartOriginFailed(),
        ],
      );
    });
  });
}
