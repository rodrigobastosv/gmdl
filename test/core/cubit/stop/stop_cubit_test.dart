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
  MockClientCubit mockClientCubit;
  MockGpsCubit mockGpsCubit;

  StopModel stop;

  group('StopCubit', () {
    setUp(() {
      stop = stopToArrival;
      mockStopRepository = MockStopRepository();
      mockRouteCubit = MockRouteCubit();
      mockGlobalInfo = MockGlobalInfo();
      mockClientCubit = MockClientCubit();
      mockGpsCubit = MockGpsCubit();
      cubit = StopCubit(
        stop: stop,
        repository: mockStopRepository,
        routeCubit: mockRouteCubit,
        globalInfo: mockGlobalInfo,
        clientCubit: mockClientCubit,
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
                clientCubit: mockClientCubit,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);
      expect(
          () => StopCubit(
                stop: stop,
                repository: null,
                routeCubit: mockRouteCubit,
                globalInfo: mockGlobalInfo,
                clientCubit: mockClientCubit,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);
      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: null,
                globalInfo: mockGlobalInfo,
                clientCubit: mockClientCubit,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);
      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: mockRouteCubit,
                globalInfo: null,
                clientCubit: mockClientCubit,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);

      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: mockRouteCubit,
                globalInfo: mockGlobalInfo,
                clientCubit: null,
                gpsCubit: mockGpsCubit,
              ),
          throwsAssertionError);

      expect(
          () => StopCubit(
                stop: stop,
                repository: mockStopRepository,
                routeCubit: mockRouteCubit,
                globalInfo: mockGlobalInfo,
                clientCubit: mockClientCubit,
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
           SHOULD emit ArrivingOnStop, ServiceTimeUpdated and ArrivedStopSuccess
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
          ArrivingOnStop(),
          ServiceTimeUpdated(0),
          ArrivedStopSuccessOnStop(),
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
           SHOULD emit ArriveStopFailed
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(mockClientCubit.schedule(any))
              .thenThrow(ArriveStopException('error'));
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
          ArrivingOnStop(),
          ArriveStopFailed('error'),
        ],
      );
    });

    group('departStop', () {
      blocTest(
        '''WHEN departStop is called
           SHOULD emit DepartingStop and DepartedStopSuccess
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
          DepartingStop(),
          DepartedStopSuccess(
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
           SHOULD emit DepartingStop and DepartedStopFailed
        ''',
        build: () {
          when(mockRouteCubit.route).thenReturn(routeWithOneStop);
          when(mockClientCubit.schedule(any))
              .thenThrow(DepartStopException('error'));
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
          DepartingStop(),
          DepartStopFailed('error'),
        ],
      );
    });

    group('cloneStop', () {
      blocTest(
        '''WHEN cloneStop is called
           SHOULD emit CloningStop and ClonedStopSuccess
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
          CloningStop(),
          ClonedStopSuccess(
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
           SHOULD emit DepartingStop and DepartedStopFailed
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
          CloningStop(),
          CloneStopFailed('error'),
        ],
      );
    });

    group('cancelStop', () {
      blocTest(
        '''WHEN cancelStop is called
           SHOULD emit CancellingStop and CanceledStopSuccess
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
          CancellingStop(),
          CanceledStopSuccess(
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
           SHOULD emit CancellingStop and CanceledStopFailed
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
          CancellingStop(),
          CanceledStopFailed('error'),
        ],
      );
    });

    group('undeliverStop', () {
      blocTest(
        '''WHEN undeliverStop is called
           SHOULD emit UndeliveringStop and UndeliveredStopSuccess
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
          UndeliveringStop(),
          UndeliveredStopSuccess(
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
           SHOULD emit UndeliveringStop and UndeliveredStopFailed
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
          UndeliveringStop(),
          UndeliveredStopFailed('error'),
        ],
      );
    });

    group('redeliverStop', () {
      blocTest(
        '''WHEN redeliverStop is called
           SHOULD emit RedeliveringStop and RedeliveredStopSuccess
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
          RedeliveringStop(),
          RedeliveredStopSuccess(
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
           SHOULD emit RedeliveringStop and RedeliveredStopFailed
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
          RedeliveringStop(),
          RedeliveredStopFailed('error'),
        ],
      );
    });
  });
}
