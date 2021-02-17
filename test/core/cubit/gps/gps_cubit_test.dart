import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';
import '../../../mocks.dart';

void main() {
  GpsCubit cubit;
  MockGpsService mockGpsService;
  MockGpsRepository mockGpsRepository;

  group('GpsCubit', () {
    setUp(() {
      mockGpsService = MockGpsService();
      mockGpsRepository = MockGpsRepository();
      cubit = GpsCubit(
        gpsService: mockGpsService,
        repository: mockGpsRepository,
      );
    });

    test('asserts', () {
      expect(
          () => GpsCubit(
                gpsService: null,
                repository: mockGpsRepository,
              ),
          throwsAssertionError);

      expect(
          () => GpsCubit(
                gpsService: mockGpsService,
                repository: null,
              ),
          throwsAssertionError);
    });

    test('initial state is GpsInitial', () {
      expect(cubit.state is GpsInitial, true);
    });

    blocTest(
      '''WHEN initPositionTracking is fired
         SHOULD start listening to gps updates
      ''',
      build: () {
        when(mockGpsService.getLocationStream()).thenAnswer(
          (_) => Stream<Position>.fromFutures([
            Future.value(Position(latitude: 0, longitude: 0)),
            Future.value(Position(latitude: 1, longitude: 1)),
            Future.value(Position(latitude: 2, longitude: 2)),
          ]),
        );
        return cubit;
      },
      act: (cubit) => cubit.initPositionTracking(),
      expect: [
        GpsDriverPositionTrackingStartSuccess(),
        GpsNewPosition(Position(latitude: 0, longitude: 0)),
        GpsNewPosition(Position(latitude: 1, longitude: 1)),
        GpsNewPosition(Position(latitude: 2, longitude: 2)),
      ],
    );

    blocTest(
      '''WHEN sendStopGpsInfo is called in ARRIVE_STOP
         SHOULD call sendStopArrivalGpsInfo
      ''',
      build: () {
        when(mockGpsService.getCurrentPosition()).thenAnswer(
          (_) async => Position(
            latitude: 0,
            longitude: 0,
            accuracy: 100,
          ),
        );
        when(mockGpsRepository.sendStopArrivalGpsInfo(
          routeId: 1,
          stopKey: '1',
          accuracyMeters: 100,
          latitude: 0,
          longitude: 0,
        )).thenAnswer((_) => Future.value());
        return cubit;
      },
      act: (cubit) => cubit.sendStopGpsInfo(
        StopEvent.ARRIVE_STOP,
        routeId: 1,
        stopKey: '1',
      ),
      expect: [],
      verify: (cubit) => verify(mockGpsRepository.sendStopArrivalGpsInfo(
        routeId: 1,
        stopKey: '1',
        accuracyMeters: 100,
        latitude: 0,
        longitude: 0,
      )).called(1),
    );

    blocTest(
      '''WHEN sendStopGpsInfo is called in DEPART_STOP
         SHOULD call sendStopDepartureGpsInfo
      ''',
      build: () {
        when(mockGpsService.getCurrentPosition()).thenAnswer(
          (_) async => Position(
            latitude: 0,
            longitude: 0,
            accuracy: 100,
          ),
        );
        when(mockGpsRepository.sendStopDepartureGpsInfo(
          routeId: 1,
          stopKey: '1',
          accuracyMeters: 100,
          latitude: 0,
          longitude: 0,
        )).thenAnswer((_) => Future.value());
        return cubit;
      },
      act: (cubit) => cubit.sendStopGpsInfo(
        StopEvent.DEPART_STOP,
        routeId: 1,
        stopKey: '1',
      ),
      expect: [],
      verify: (cubit) => verify(mockGpsRepository.sendStopDepartureGpsInfo(
        routeId: 1,
        stopKey: '1',
        accuracyMeters: 100,
        latitude: 0,
        longitude: 0,
      )).called(1),
    );

    blocTest(
      '''WHEN sendStopGpsInfo is called in CANCEL_STOP
         SHOULD call sendStopCancelGpsInfo
      ''',
      build: () {
        when(mockGpsService.getCurrentPosition()).thenAnswer(
          (_) async => Position(
            latitude: 0,
            longitude: 0,
            accuracy: 100,
          ),
        );
        when(mockGpsRepository.sendStopCancelGpsInfo(
          routeId: 1,
          stopKey: '1',
          accuracyMeters: 100,
          latitude: 0,
          longitude: 0,
        )).thenAnswer((_) => Future.value());
        return cubit;
      },
      act: (cubit) => cubit.sendStopGpsInfo(
        StopEvent.CANCEL_STOP,
        routeId: 1,
        stopKey: '1',
      ),
      expect: [],
      verify: (cubit) => verify(mockGpsRepository.sendStopCancelGpsInfo(
        routeId: 1,
        stopKey: '1',
        accuracyMeters: 100,
        latitude: 0,
        longitude: 0,
      )).called(1),
    );
  });
}
