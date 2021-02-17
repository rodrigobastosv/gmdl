import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import '../../../mocks.dart';

void main() {
  MapCubit cubit;
  MockRouteCubit mockRouteCubit;

  group('HosCubit', () {
    setUp(() {
      mockRouteCubit = MockRouteCubit();
      cubit = MapCubit(
        routeCubit: mockRouteCubit,
      );
    });

    test('asserts', () {
      expect(
          () => MapCubit(
                routeCubit: null,
              ),
          throwsAssertionError);
    });

    test('initial state is MapInitial', () {
      expect(cubit.state is MapInitial, true);
    });

    test('routeCubit getter', () {
      expect(cubit.routeCubit is RouteCubit, true);
    });

    blocTest(
      '''WHEN init
         AND RouteCubit emit RouteDriverPositionUpdate
         SHOULD emit MapUpdateDriverPosition
      ''',
      build: () {
        whenListen(
          mockRouteCubit,
          Stream.fromIterable(
            [
              RouteDriverPositionUpdate(
                Position(
                  latitude: 0,
                  longitude: 0,
                ),
              ),
            ],
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: [
        MapUpdateDriverPosition(
          Position(
            latitude: 0,
            longitude: 0,
          ),
        ),
      ],
    );

    blocTest(
      '''WHEN init
         AND RouteCubit emit RouteArriveStopSuccess
         SHOULD emit MapShowStop
      ''',
      build: () {
        whenListen(
          mockRouteCubit,
          Stream.fromIterable(
            [
              RouteArriveStopSuccess(StopModel()),
            ],
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: [
        MapShowStop(null),
      ],
    );

    blocTest(
      '''WHEN init
         AND RouteCubit emit RouteUpdateDueStopChange
         SHOULD emit RouteUpdated
      ''',
      build: () {
        whenListen(
          mockRouteCubit,
          Stream.fromIterable(
            [
              RouteUpdateDueStopChange(StopModel()),
            ],
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: [
        RouteUpdated(),
      ],
    );

    blocTest(
      '''WHEN init
         AND RouteCubit emit RouteUpdateDueNotificationSuccess
         SHOULD emit RouteUpdated
      ''',
      build: () {
        whenListen(
          mockRouteCubit,
          Stream.fromIterable(
            [
              RouteUpdateDueNotificationSuccess(
                notificationId: '1',
                notificationAction: NotificationAction.ADD_STOP,
              ),
            ],
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.init(),
      expect: [
        RouteUpdatedDueOptimization(),
      ],
    );

    blocTest(
      '''WHEN showStopOnMap
         SHOULD emit MapShowStop
      ''',
      build: () => cubit,
      act: (cubit) => cubit.showStopOnMap(StopModel()),
      expect: [
        MapShowStop(StopModel()),
      ],
    );
  });
}
