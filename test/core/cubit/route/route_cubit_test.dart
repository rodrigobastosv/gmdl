import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/driver_info_dto.dart';
import 'package:gm_driver_lite/core/entity/dto/notification_dto.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/entity/model/route_model.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:gm_driver_lite/core/extension/extensions.dart';
import '../../../mocks.dart';

void main() {
  RouteCubit cubit;
  MockRouteRepository mockRouteRepository;
  MockGlobalInfo mockGlobalInfo;
  MockNotificationCubit mockNotificationCubit;
  MockHosCubit mockHosCubit;
  MockGpsCubit mockGpsCubit;
  MockLaunchService mockLaunchService;

  RouteModel route;
  StopModel stopToArrive;

  final actualArrivalStop = DateTime.now().toUtcAsString;
  final actualDepartureStop = DateTime.now().toUtcAsString;

  group('RouteCubit', () {
    setUpAll(() {
      mockRouteRepository = MockRouteRepository();
      mockGlobalInfo = MockGlobalInfo();
      mockNotificationCubit = MockNotificationCubit();
      mockHosCubit = MockHosCubit();
      mockGpsCubit = MockGpsCubit();
      mockLaunchService = MockLaunchService();
    });

    setUp(() {
      stopToArrive = StopModel(
        id: 1,
      );
      route = RouteModel(
        id: 1,
        stops: [
          stopToArrive,
        ],
      );
      cubit = RouteCubit(
        route: route,
        repository: mockRouteRepository,
        globalInfo: mockGlobalInfo,
        notificationCubit: mockNotificationCubit,
        hosCubit: mockHosCubit,
        gpsCubit: mockGpsCubit,
        launchService: mockLaunchService,
      );
    });

    tearDownAll(() => cubit.close());

    test('asserts', () {
      expect(
          () => RouteCubit(
                route: null,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
                hosCubit: mockHosCubit,
                gpsCubit: mockGpsCubit,
                launchService: mockLaunchService,
              ),
          throwsAssertionError);
      expect(
          () => RouteCubit(
                route: route,
                repository: null,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
                hosCubit: mockHosCubit,
                gpsCubit: mockGpsCubit,
                launchService: mockLaunchService,
              ),
          throwsAssertionError);
      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: null,
                notificationCubit: mockNotificationCubit,
                hosCubit: mockHosCubit,
                gpsCubit: mockGpsCubit,
                launchService: mockLaunchService,
              ),
          throwsAssertionError);

      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: null,
                hosCubit: mockHosCubit,
                gpsCubit: mockGpsCubit,
                launchService: mockLaunchService,
              ),
          throwsAssertionError);

      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
                hosCubit: null,
                gpsCubit: mockGpsCubit,
                launchService: mockLaunchService,
              ),
          throwsAssertionError);

      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
                hosCubit: mockHosCubit,
                gpsCubit: null,
                launchService: mockLaunchService,
              ),
          throwsAssertionError);

      expect(
          () => RouteCubit(
                route: route,
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                notificationCubit: mockNotificationCubit,
                hosCubit: mockHosCubit,
                gpsCubit: mockGpsCubit,
                launchService: null,
              ),
          throwsAssertionError);
    });

    test('initial state is RouteInitial', () {
      expect(cubit.state is RouteInitial, true);
    });

    test('driverName getter', () {
      when(mockGlobalInfo.driverInfo).thenReturn(DriverInfoDto(name: 'driver'));
      expect(cubit.driverName, 'driver');
    });

    test('token getter', () {
      when(mockNotificationCubit.fcmToken).thenReturn('myToken');
      expect(cubit.token, 'myToken');
    });

    group('init', () {
      blocTest(
        '''WHEN init is called
           SHOULD emit nothing
        ''',
        build: () {
          return cubit;
        },
        act: (cubit) => cubit.init(),
        expect: [],
      );

      blocTest(
        '''WHEN init is called
           AND NotificationCubit emits NotificationReceived
           AND the notification action is ROUTE_PLANNED_UPDATE
           SHOULD emit RouteUpdateDueNotificationSuccess
        ''',
        build: () {
          when(mockRouteRepository.syncRouteByNotification(route.id))
              .thenAnswer(
            (_) async => RouteModel(
              id: 1,
            ),
          );
          whenListen<NotificationState>(
            mockNotificationCubit,
            Stream.fromIterable(
              [
                NotificationReceive(
                  NotificationDto(
                    id: '1',
                    action: NotificationAction.ROUTE_PLANNED_UPDATE,
                  ),
                ),
              ],
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.init(),
        expect: [
          RouteUpdateDueNotificationSuccess(
            notificationId: '1',
            notificationAction: NotificationAction.ROUTE_PLANNED_UPDATE,
          ),
        ],
        verify: (cubit) {
          verify(mockRouteRepository.syncRouteByNotification(1)).called(1);
        },
      );

      blocTest(
        '''WHEN init is called
           AND NotificationCubit emits NotificationReceived
           AND the notification action is ROUTE_PLANNED_UPDATE
           AND fails to sync route
           SHOULD emit RouteUpdateDueNotificationFailure
        ''',
        build: () {
          when(mockRouteRepository.syncRouteByNotification(route.id))
              .thenThrow(Exception());
          whenListen<NotificationState>(
            mockNotificationCubit,
            Stream.fromIterable(
              [
                NotificationReceive(
                  NotificationDto(
                    id: '1',
                    action: NotificationAction.ROUTE_PLANNED_UPDATE,
                  ),
                ),
              ],
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.init(),
        expect: [
          RouteUpdateDueNotificationFailure(
            notificationId: '1',
            notificationAction: NotificationAction.ROUTE_PLANNED_UPDATE,
          ),
        ],
        verify: (cubit) {
          verify(mockRouteRepository.syncRouteByNotification(1)).called(1);
        },
      );
    });

    group('startRoute', () {
      blocTest(
        '''WHEN startRoute is called
           SHOULD emit RouteStartLoad and RouteStartSuccess
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
          RouteStartLoad(),
          RouteStartSuccess(),
        ],
      );

      test(
        '''WHEN route is started 
           SHOULD change route status to STARTED
        ''',
        () async {
          when(mockRouteRepository.startRoute(route.id))
              .thenAnswer((_) => Future.value());
          when(mockRouteRepository.fetchProConfig(route.id))
              .thenAnswer((_) async => null);

          expect(cubit.route.status == RouteStatus.STARTED, false);
          await cubit.startRoute();
          expect(cubit.route.status == RouteStatus.STARTED, true);
        },
      );

      blocTest(
        '''WHEN startRoute is called 
           AND has PRO config
           SHOULD emit RouteStartLoad, RouteProConfigApply, RouteStartSuccess
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
          RouteStartLoad(),
          RouteProConfigApply(ProactiveRouteOptConfigModel()),
          RouteStartSuccess(),
        ],
      );

      test(
        '''WHEN start route
           AND has pro config
           SHOULD apply pro config to route
        ''',
        () async {
          when(mockRouteRepository.startRoute(route.id))
              .thenAnswer((_) => Future.value());
          when(mockRouteRepository.fetchProConfig(route.id))
              .thenAnswer((_) async => ProactiveRouteOptConfigModel());

          expect(cubit.route.isUsingPro, false);
          await cubit.startRoute();
          expect(cubit.route.isUsingPro, true);
        },
      );

      blocTest(
        '''WHEN startRoute throws Exception
           SHOULD emit RouteStartLoad and RouteStartFailed
        ''',
        build: () {
          when(mockRouteRepository.startRoute(route.id))
              .thenThrow(StartRouteException('error'));
          return cubit;
        },
        act: (cubit) => cubit.startRoute(),
        expect: [
          RouteStartLoad(),
          RouteStartFailed('error'),
        ],
      );
    });

    group('departOrigin', () {
      blocTest(
        '''WHEN departOrigin is called
           SHOULD emit RouteDepartOriginLoad and DepartOriginSuccess
        ''',
        build: () {
          when(mockRouteRepository.departOrigin(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.departOrigin(),
        expect: [
          RouteDepartOriginLoad(),
          RouteDepartOriginSuccess(),
        ],
      );

      test(
        '''WHEN route departed
           SHOULD change route status to DEPARTED_ORIGIN
        ''',
        () async {
          when(mockRouteRepository.departOrigin(route.id))
              .thenAnswer((_) => Future.value());

          expect(cubit.route.status == RouteStatus.DEPARTED_ORIGIN, false);
          await cubit.departOrigin();
          expect(cubit.route.status == RouteStatus.DEPARTED_ORIGIN, true);
        },
      );

      blocTest(
        '''WHEN departOrigin is called
           SHOULD emit RouteDepartOriginLoad and RouteDepartOriginSuccess
        ''',
        build: () {
          when(mockRouteRepository.departOrigin(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.departOrigin(),
        expect: [
          RouteDepartOriginLoad(),
          RouteDepartOriginSuccess(),
        ],
      );

      blocTest(
        '''WHEN departOrigin throws DepartOriginException
           SHOULD emit RouteDepartOriginLoad and RouteDepartOriginFailure
        ''',
        build: () {
          when(mockRouteRepository.departOrigin(route.id))
              .thenThrow(DepartOriginException('error'));
          return cubit;
        },
        act: (cubit) => cubit.departOrigin(),
        expect: [
          RouteDepartOriginLoad(),
          RouteDepartOriginFailure(),
        ],
      );
    });

    group('arriveStop', () {
      blocTest(
        '''WHEN arriveStop is called
           SHOULD emit RouteArriveStopLoad and RouteArriveStopSuccess
        ''',
        build: () {
          when(
            mockRouteRepository.arriveStop(
              routeId: route.id,
              stop: stopToArrive,
              actualArrival: actualArrivalStop,
            ),
          ).thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.arriveStop(
          stop: stopToArrive,
          actualArrival: actualArrivalStop,
        ),
        expect: [
          RouteArriveStopLoad(
            StopModel(
              id: 1,
            ),
          ),
          RouteArriveStopSuccess(
            StopModel(
              id: 1,
            ).copyWith(actualArrival: actualArrivalStop),
          ),
        ],
      );

      test(
        '''WHEN arrives stop 
           SHOULD update actualArrival of stop
        ''',
        () async {
          when(
            mockRouteRepository.arriveStop(
              routeId: route.id,
              stop: stopToArrive,
              actualArrival: actualArrivalStop,
            ),
          ).thenAnswer((_) => Future.value());
          await cubit.arriveStop(
            stop: stopToArrive,
            actualArrival: actualArrivalStop,
          );
          expect(cubit.route.stops[0].actualArrival, actualArrivalStop);
        },
      );

      blocTest(
        '''WHEN arriveStop throws ArriveStopException
           SHOULD emit RouteArriveStopLoad and RouteArriveStopFailure
        ''',
        build: () {
          when(
            mockRouteRepository.arriveStop(
              routeId: route.id,
              stop: stopToArrive,
              actualArrival: actualArrivalStop,
            ),
          ).thenThrow(ArriveStopException('error'));
          return cubit;
        },
        act: (cubit) => cubit.arriveStop(
          stop: stopToArrive,
          actualArrival: actualArrivalStop,
        ),
        expect: [
          RouteArriveStopLoad(
            StopModel(
              id: 1,
            ),
          ),
          RouteArriveStopFailure('error'),
        ],
      );
    });

    group('updateRouteDueStopChange', () {
      blocTest(
        '''WHEN updateRouteDueStopChange is called
           SHOULD emit RouteUpdateDueStopChange
        ''',
        build: () => cubit,
        act: (cubit) => cubit.updateRouteDueStopChange(StopModel(id: 1)),
        expect: [
          RouteUpdateDueStopChange(StopModel(id: 1)),
        ],
      );

      blocTest(
        '''WHEN updateRouteDueStopChange is called
           AND theres no pending stop left
           SHOULD emit RouteUpdateDueStopChange and RouteHasNoPendingStops
        ''',
        build: () {
          cubit.route = cubit.route.copyWith(
            stops: [
              StopModel(
                id: 1,
                actualDeparture: actualDepartureStop,
              ),
            ],
          );
          return cubit;
        },
        act: (cubit) => cubit.updateRouteDueStopChange(
          StopModel(
            id: 1,
            actualDeparture: actualDepartureStop,
          ),
        ),
        expect: [
          RouteUpdateDueStopChange(
            StopModel(
              id: 1,
              actualDeparture: actualDepartureStop,
            ),
          ),
          RouteHasNoPendingStops(),
        ],
      );
    });

    group('updateRouteDueClonedStop', () {
      blocTest(
        '''WHEN updateRouteDueClonedStop is called
           SHOULD emit RouteUpdateDueStopClone
        ''',
        build: () => cubit,
        act: (cubit) => cubit.updateRouteDueClonedStop(StopModel(id: 1)),
        expect: [
          RouteUpdateDueStopClone(StopModel(id: 1)),
        ],
      );

      test(
        '''WHEN updateRouteDueClonedStop is called
           SHOULD add one more stop to the route
        ''',
        () {
          expect(cubit.route.stops.length, 1);
          cubit.updateRouteDueClonedStop(StopModel(id: 1));
          expect(cubit.route.stops.length, 2);
        },
      );
    });

    group('updateRouteDueRedeliverStop', () {
      blocTest(
        '''WHEN updateRouteDueRedeliverStop is called
           SHOULD emit RouteUpdateDueStopRedeliver
        ''',
        build: () {
          when(mockRouteRepository.arriveWarehouse(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.updateRouteDueRedeliverStop(StopModel(id: 1)),
        expect: [
          RouteUpdateDueStopRedeliver(StopModel(id: 1)),
        ],
      );

      blocTest(
        '''WHEN updateRouteDueRedeliverStop is called
           SHOULD emit RouteUpdateDueStopRedeliver
        ''',
        build: () {
          when(mockRouteRepository.arriveWarehouse(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.updateRouteDueRedeliverStop(StopModel(id: 1)),
        expect: [
          RouteUpdateDueStopRedeliver(StopModel(id: 1)),
        ],
      );
    });

    group('arriveWarehouse', () {
      blocTest(
        '''WHEN arriveWarehouse is called successfuly
           SHOULD emit RouteArriveWarehouseLoad and RouteArriveWarehouseSuccess
        ''',
        build: () {
          when(mockRouteRepository.arriveWarehouse(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.arriveWarehouse(),
        expect: [
          RouteArriveWarehouseLoad(),
          RouteArriveWarehouseSuccess(),
        ],
      );

      blocTest(
        '''WHEN arriveWarehouse throws Exception
           SHOULD emit RouteArriveWarehouseLoad and RouteArriveWarehouseFailure
        ''',
        build: () {
          when(mockRouteRepository.arriveWarehouse(route.id))
              .thenThrow(ArriveWarehouseException('error'));
          return cubit;
        },
        act: (cubit) => cubit.arriveWarehouse(),
        expect: [
          RouteArriveWarehouseLoad(),
          RouteArriveWarehouseFailure(),
        ],
      );
    });

    group('completeRoute', () {
      blocTest(
        '''WHEN completeRoute is called successfuly
           SHOULD emit RouteCompleteLoad and RouteCompleteSuccess
        ''',
        build: () {
          when(mockRouteRepository.completeRoute(route.id))
              .thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.completeRoute(),
        expect: [
          RouteCompleteLoad(),
          RouteCompleteSuccess(),
        ],
      );

      test(
        '''WHEN complete route is called
           SHOULD update the status of the Route to COMPLETED
        ''',
        () async {
          when(
            mockRouteRepository.completeRoute(route.id),
          ).thenAnswer((_) => Future.value());
          expect(cubit.route.status == RouteStatus.COMPLETED, false);
          await cubit.completeRoute();
          expect(cubit.route.status == RouteStatus.COMPLETED, true);
        },
      );

      blocTest(
        '''WHEN completeRoute throws CompleteRouteException
           SHOULD emit RouteCompleteLoad and RouteCompleteFailure
        ''',
        build: () {
          when(mockRouteRepository.completeRoute(route.id))
              .thenThrow(CompleteRouteException('error'));
          return cubit;
        },
        act: (cubit) => cubit.completeRoute(),
        expect: [
          RouteCompleteLoad(),
          RouteCompleteFailure(),
        ],
      );
    });
  });
}
