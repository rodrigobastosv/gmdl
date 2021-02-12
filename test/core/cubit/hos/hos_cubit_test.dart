@Timeout(Duration(minutes: 2))

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:gm_driver_lite/core/extension/extensions.dart';
import 'package:gm_driver_lite/core/utils/utils.dart';
import '../../../mocks.dart';

void main() {
  HosCubit cubit;
  MockHosRepository mockHosRepository;
  MockGlobalInfo mockGlobalInfo;

  final now = DateTime.now().toUtcAsString;

  group('HosCubit', () {
    setUp(() {
      mockHosRepository = MockHosRepository();
      mockGlobalInfo = MockGlobalInfo();
      cubit = HosCubit(
        repository: mockHosRepository,
        globalInfo: mockGlobalInfo,
      );
    });

    test('asserts', () {
      expect(
          () => HosCubit(
                repository: null,
                globalInfo: mockGlobalInfo,
              ),
          throwsAssertionError);

      expect(
          () => HosCubit(
                repository: mockHosRepository,
                globalInfo: null,
              ),
          throwsAssertionError);
    });

    test('initial state is HosInitial', () {
      expect(cubit.state is HosInitial, true);
    });

    blocTest(
      '''WHEN startLunch is called
         SHOULD emit HosLunchStartSuccess
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenReturn(DriverInfoDto(
          id: 1,
        ));
        when(mockHosRepository.startLunch(
          driverId: 1,
          eventTime: now,
        )).thenAnswer((_) async => Future.value());
        return cubit;
      },
      act: (cubit) => cubit.startLunch(now),
      expect: [
        HosLunchStartSuccess(),
      ],
    );

    blocTest(
      '''WHEN startLunch is called
         AND a minute pass
         SHOULD emit HosLunchStartSuccess and HosLunchTimeMinutePass
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenReturn(DriverInfoDto(
          id: 1,
        ));
        when(mockHosRepository.startLunch(
          driverId: 1,
          eventTime: now,
        )).thenAnswer((_) async => Future.value());
        return cubit;
      },
      act: (cubit) async {
        cubit.startLunch(now);
        await Future.delayed(ONE_MINUTE);
      },
      expect: [
        HosLunchStartSuccess(),
        HosLunchTimeMinutePass(1),
      ],
    );

    blocTest(
      '''WHEN startLunch throws HosEventException
         SHOULD emit HosLunchStartFailure
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenThrow(HosEventException('error'));
        when(mockHosRepository.startLunch(
          driverId: 1,
          eventTime: now,
        )).thenAnswer((_) async => Future.value());
        return cubit;
      },
      act: (cubit) => cubit.startLunch(now),
      expect: [
        HosLunchStartFailure('error'),
      ],
    );

    blocTest(
      '''WHEN endLunch is called
         SHOULD emit HosLunchEndSuccess
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenReturn(DriverInfoDto(
          id: 1,
        ));
        when(mockHosRepository.endLunch(
          driverId: 1,
          eventTime: now,
        )).thenAnswer((_) async => Future.value());
        return cubit;
      },
      act: (cubit) {
        cubit.startLunch(now);
        cubit.endLunch(now);
      },
      expect: [
        HosLunchStartSuccess(),
        HosLunchEndSuccess(),
      ],
    );

    blocTest(
      '''WHEN endLunch throws HosEventException
         SHOULD emit HosLunchEndSuccess
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenReturn(DriverInfoDto(
          id: 1,
        ));
        when(mockHosRepository.endLunch(
          driverId: 1,
          eventTime: now,
        )).thenThrow(HosEventException('error'));
        return cubit;
      },
      act: (cubit) {
        cubit.startLunch(now);
        cubit.endLunch(now);
      },
      expect: [
        HosLunchStartSuccess(),
        HosLunchEndFailure('error'),
      ],
    );
  });
}
