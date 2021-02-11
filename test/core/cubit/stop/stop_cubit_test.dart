import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import '../../../mocks.dart';
import 'mock_data.dart';

void main() {
  StopCubit cubit;
  MockStopRepository mockStopRepository;
  MockRouteCubit mockRouteCubit;
  MockGlobalInfo mockGlobalInfo;
  MockGpsCubit mockGpsCubit;

  StopModel stop;

  group('StopCubit', () {
    setUp(() {
      stop = stopToArrival;
      mockStopRepository = MockStopRepository();
      mockRouteCubit = MockRouteCubit();
      mockGlobalInfo = MockGlobalInfo();
      mockGpsCubit = MockGpsCubit();
      cubit = StopCubit(
        stop: stop,
        repository: mockStopRepository,
        routeCubit: mockRouteCubit,
        globalInfo: mockGlobalInfo,
        gpsCubit: mockGpsCubit,
      );
    });

    test('asserts', () {
      expect(
          () => StopCubit(
                stop: null,
                repository: mockStopRepository,
                routeCubit: mockRouteCubit,
                globalInfo: mockGlobalInfo,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);
      expect(
          () => StopCubit(
                stop: stop,
                repository: null,
                routeCubit: mockRouteCubit,
                globalInfo: mockGlobalInfo,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);
      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: null,
                globalInfo: mockGlobalInfo,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);
      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: mockRouteCubit,
                globalInfo: null,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);

      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: mockRouteCubit,
                globalInfo: mockGlobalInfo,
                gpsCubit: null,
              ),
          throwsAssertionError);
    });

    test('allCancelCodes getter', () {
      when(mockGlobalInfo.cancelCodes).thenReturn([]);
      expect(cubit.allCancelCodes, isEmpty);
    });

    test('allUndeliveableCodes getter', () {
      when(mockGlobalInfo.undeliverableCodes).thenReturn([]);
      expect(cubit.allUndeliveableCodes, isEmpty);
    });

    test('initial state is StopInitial', () {
      expect(cubit.state is StopInitial, true);
    });

    group('arriveStop', () {
      blocTest(
        '''WHEN arriveStop is called
           SHOULD emit StopArriveLoad, StopServiceTimeUpdate and StopArriveSuccess
           AND updateRouteDueStopChange of route cubit should be called
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.arriveStop(
              routeId: routeWithOneStop.id,
              stop: stop,
              actualArrival: actualArrivalStop,
            ),
          ).thenAnswer((_) async => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.arriveStop(actualArrivalStop),
        expect: [
          StopArriveLoad(),
          StopServiceTimeUpdate(0),
          StopArriveSuccess(),
        ],
        verify: (cubit) {
          verify(
            mockRouteCubit.updateRouteDueStopChange(
              stop.copyWith(
                actualArrival: actualArrivalStop,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''WHEN arriveStop is called on a Stop
           SHOULD update stop's actualArrival
        ''',
        () async {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.arriveStop(
              routeId: routeWithOneStop.id,
              stop: stop,
              actualArrival: actualArrivalStop,
            ),
          ).thenAnswer((_) async => Future.value());
          await cubit.arriveStop(actualArrivalStop);
          expect(cubit.stop.actualArrival, actualArrivalStop);
        },
      );

      blocTest(
        '''WHEN arriveStop throws ArriveStopException
           SHOULD emit StopArriveLoad and StopArriveFailure
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.arriveStop(
              routeId: routeWithOneStop.id,
              stop: stop,
              actualArrival: actualArrivalStop,
            ),
          ).thenThrow(ArriveStopException('error'));
          return cubit;
        },
        act: (cubit) => cubit.arriveStop(actualArrivalStop),
        expect: [
          StopArriveLoad(),
          StopArriveFailure('error'),
        ],
      );
    });

    group('departStop', () {
      blocTest(
        '''WHEN departStop is called
           SHOULD emit StopDepartLoad and StopDepartSuccess
           AND updateRouteDueStopChange of route cubit should be called
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.departStop(
              routeId: routeWithOneStop.id,
              stop: stop,
              actualDeparture: actualDepartureStop,
            ),
          ).thenAnswer((_) async => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.departStop(actualDepartureStop),
        expect: [
          StopDepartLoad(),
          StopDepartSuccess(
            StopModel(
              id: 1,
            ).copyWith(
              actualDeparture: actualDepartureStop,
            ),
          ),
        ],
        verify: (cubit) {
          verify(
            mockRouteCubit.updateRouteDueStopChange(
              stop.copyWith(
                actualDeparture: actualDepartureStop,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''WHEN departStop is called on a Stop
           SHOULD update stop's actualDeparture
        ''',
        () async {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.departStop(
              routeId: routeWithOneStop.id,
              stop: stop,
              actualDeparture: actualDepartureStop,
            ),
          ).thenAnswer((_) async => Future.value());
          await cubit.departStop(actualDepartureStop);
          expect(cubit.stop.actualDeparture, actualDepartureStop);
        },
      );

      blocTest(
        '''WHEN departStop throws DepartStopException
           SHOULD emit StopDepartLoad and StopDepartFailure
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.departStop(
              routeId: routeWithOneStop.id,
              stop: stop,
              actualDeparture: actualDepartureStop,
            ),
          ).thenThrow(DepartStopException('error'));
          return cubit;
        },
        act: (cubit) async => await cubit.departStop(actualArrivalStop),
        expect: [
          StopDepartLoad(),
          StopDepartFailure('error'),
        ],
      );
    });

    group('cloneStop', () {
      blocTest(
        '''WHEN cloneStop is called
           SHOULD emit StopCloneLoad and StopCloneSuccess
           AND updateRouteDueClonedStop of route cubit should be called
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.cloneStop(
              routeId: routeWithOneStop.id,
              stop: stop,
            ),
          ).thenAnswer(
            (_) async => StopModel(
              id: 2,
              key: 'clone-key',
              plannedSequenceNum: 2,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.cloneStop(cloneDateStop),
        expect: [
          StopCloneLoad(),
          StopCloneSuccess(
            StopModel(
              id: 2,
              key: 'clone-key',
              plannedSequenceNum: 2,
              cloneDate: cloneDateStop,
            ),
          ),
        ],
        verify: (cubit) {
          verify(
            mockRouteCubit.updateRouteDueClonedStop(
              StopModel(
                id: 2,
                key: 'clone-key',
                plannedSequenceNum: 2,
                cloneDate: cloneDateStop,
              ),
            ),
          ).called(1);
        },
      );

      test(
        '''WHEN cloneStop is called on a Stop
           SHOULD update cloneDate of the stop
        ''',
        () async {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.cloneStop(
              routeId: routeWithOneStop.id,
              stop: stop,
            ),
          ).thenAnswer(
            (_) async => clonedStop,
          );
          await cubit.cloneStop(cloneDateStop);
          expect(cubit.stop.cloneDate, cloneDateStop);
          expect(cubit.stop.isCloned, true);
        },
      );

      blocTest(
        '''WHEN cloneStop throws CloneStopException
           SHOULD emit StopCloneLoad and StopCloneFailure
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.cloneStop(
              routeId: routeWithOneStop.id,
              stop: stop,
            ),
          ).thenThrow(CloneStopException('error'));
          return cubit;
        },
        act: (cubit) => cubit.cloneStop(cloneDateStop),
        expect: [
          StopCloneLoad(),
          StopCloneFailure('error'),
        ],
      );
    });

    group('cancelStop', () {
      blocTest(
        '''WHEN cancelStop is called
           SHOULD emit StopCancelLoad and StopCancelSuccess
           AND updateRouteDueStopChange of route cubit should be called
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.cancelStop(
              routeId: routeWithOneStop.id,
              actualCancel: actualCancelStop,
              cancelCode: 1,
              stopKey: stop.key,
            ),
          ).thenAnswer(
            (_) async => Future.value(),
          );
          return cubit;
        },
        act: (cubit) => cubit.cancelStop(
          cancelCode: CancelCodeModel(
            id: 1,
          ),
          actualCancel: actualCancelStop,
        ),
        expect: [
          StopCancelLoad(),
          StopCancelSuccess(
            StopModel(
              id: 1,
            ).copyWith(
              canceled: true,
              cancelCode: CancelCodeModel(
                id: 1,
              ),
            ),
          ),
        ],
        verify: (cubit) {
          verify(
            mockStopRepository.cancelStop(
              routeId: routeWithOneStop.id,
              actualCancel: actualCancelStop,
              cancelCode: 1,
              stopKey: stop.key,
            ),
          ).called(1);
        },
      );

      test(
        '''WHEN cancelStop is called on a Stop
           SHOULD update cancel status of the stop
        ''',
        () async {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.cancelStop(
              routeId: routeWithOneStop.id,
              actualCancel: actualCancelStop,
              cancelCode: 1,
              stopKey: stop.key,
            ),
          ).thenAnswer((_) async => Future.value());
          expect(cubit.stop.canceled, null);
          await cubit.cancelStop(
            cancelCode: CancelCodeModel(
              id: 1,
            ),
            actualCancel: cloneDateStop,
          );
          expect(cubit.stop.canceled, true);
        },
      );

      blocTest(
        '''WHEN cancelStop throws CancelStopException
           SHOULD emit StopCancelLoad and StopCancelFailure
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.cancelStop(
              routeId: routeWithOneStop.id,
              actualCancel: actualCancelStop,
              cancelCode: 1,
              stopKey: stop.key,
            ),
          ).thenThrow(CancelStopException('error'));
          return cubit;
        },
        act: (cubit) => cubit.cancelStop(
          cancelCode: CancelCodeModel(
            id: 1,
          ),
          actualCancel: actualCancelStop,
        ),
        expect: [
          StopCancelLoad(),
          StopCancelFailure('error'),
        ],
      );
    });

    group('undeliverStop', () {
      blocTest(
        '''WHEN undeliverStop is called
           SHOULD emit StopUndeliverLoad and StopUndeliverSuccess
           AND updateRouteDueStopChange of route cubit should be called
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.undeliverStop(
              routeId: routeWithOneStop.id,
              undeliverableCode: 1,
              actualDeparture: actualDepartureStop,
              stopKey: stop.key,
            ),
          ).thenAnswer(
            (_) async => Future.value(),
          );
          return cubit;
        },
        act: (cubit) => cubit.undeliverStop(
          undeliverableCode: UndeliverableCodeModel(
            id: 1,
          ),
          actualDeparture: actualDepartureStop,
        ),
        expect: [
          StopUndeliverLoad(),
          StopUndeliverSuccess(
            StopModel(
              id: 1,
            ).copyWith(
              actualDeparture: actualDepartureStop,
              undeliverableCode: UndeliverableCodeModel(
                id: 1,
              ),
            ),
          ),
        ],
        verify: (cubit) {
          verify(
            mockStopRepository.undeliverStop(
              routeId: routeWithOneStop.id,
              undeliverableCode: 1,
              actualDeparture: actualDepartureStop,
              stopKey: stop.key,
            ),
          ).called(1);
        },
      );

      test(
        '''WHEN undeliverStop is called on a Stop
           SHOULD update undeliverableCode and actualDeparture of the stop
        ''',
        () async {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.undeliverStop(
              routeId: routeWithOneStop.id,
              undeliverableCode: 1,
              actualDeparture: actualDepartureStop,
              stopKey: stop.key,
            ),
          ).thenAnswer((_) async => Future.value());
          expect(cubit.stop.undeliverableCode, isNull);
          expect(cubit.stop.actualDeparture, isNull);
          await cubit.undeliverStop(
            undeliverableCode: UndeliverableCodeModel(
              id: 1,
            ),
            actualDeparture: actualDepartureStop,
          );
          expect(cubit.stop.undeliverableCode, isNotNull);
          expect(cubit.stop.actualDeparture, isNotNull);
        },
      );

      blocTest(
        '''WHEN undeliverStop throws UndeliverStopException
           SHOULD emit StopUndeliverLoad and StopUndeliverFailure
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.undeliverStop(
              routeId: routeWithOneStop.id,
              undeliverableCode: 1,
              actualDeparture: actualDepartureStop,
              stopKey: stop.key,
            ),
          ).thenThrow(UndeliverStopException('error'));
          return cubit;
        },
        act: (cubit) => cubit.undeliverStop(
          undeliverableCode: UndeliverableCodeModel(
            id: 1,
          ),
          actualDeparture: actualDepartureStop,
        ),
        expect: [
          StopUndeliverLoad(),
          StopUndeliverFailure('error'),
        ],
      );
    });

    group('redeliverStop', () {
      blocTest(
        '''WHEN redeliverStop is called
           SHOULD emit StopRedeliverLoad and StopRedeliverSuccess
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithTwoStop);
          when(
            mockStopRepository.redeliverStop(
              routeId: routeWithOneStop.id,
              undeliverableCode: 1,
              actualDeparture: actualDepartureStop,
              undeliveredStopKey: stop.key,
              newStopKey: anyNamed('newStopKey'),
            ),
          ).thenAnswer(
            (_) async => Future.value(),
          );
          return cubit;
        },
        act: (cubit) => cubit.redeliverStop(
          undeliverableCode: UndeliverableCodeModel(
            id: 1,
          ),
          actualDeparture: actualDepartureStop,
        ),
        expect: [
          StopRedeliverLoad(),
          StopRedeliverSuccess(
            StopModel(
              id: 1,
            ).copyWith(
              actualDeparture: actualDepartureStop,
              undeliverableCode: UndeliverableCodeModel(
                id: 1,
              ),
              redeliveryStop: StopModel().copyWith(
                id: 2,
                key: 'newStopKey',
                plannedSequenceNum: 2,
                actualArrival: null,
              ),
            ),
          ),
        ],
      );

      blocTest(
        '''WHEN redeliverStop throws RedeliverStopException
           SHOULD emit StopRedeliverLoad and StopRedeliverFailure
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(
            mockStopRepository.redeliverStop(
              routeId: routeWithOneStop.id,
              undeliverableCode: 1,
              actualDeparture: actualDepartureStop,
              undeliveredStopKey: stop.key,
              newStopKey: anyNamed('newStopKey'),
            ),
          ).thenThrow(RedeliverStopException('error'));
          return cubit;
        },
        act: (cubit) => cubit.redeliverStop(
          undeliverableCode: UndeliverableCodeModel(
            id: 1,
          ),
          actualDeparture: actualDepartureStop,
        ),
        expect: [
          StopRedeliverLoad(),
          StopRedeliverFailure('error'),
        ],
      );
    });
  });
}
