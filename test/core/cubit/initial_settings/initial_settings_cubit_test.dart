import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/locale_model.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:gm_driver_lite/core/global/hive.dart';
import '../../../mocks.dart';

void main() {
  InitialSettingsCubit cubit;
  MockInitialSettingsRepository mockInitialSettingsRepository;
  MockBox mockBox;

  final locales = [
    LocaleModel(id: 1),
    LocaleModel(id: 2),
    LocaleModel(id: 3),
  ];

  group('InitialSettingsCubit', () {
    setUp(() {
      mockInitialSettingsRepository = MockInitialSettingsRepository();
      mockBox = MockBox();
      cubit = InitialSettingsCubit(
        repository: mockInitialSettingsRepository,
        globalBox: mockBox,
      );
    });

    test('asserts', () {
      expect(
          () => InitialSettingsCubit(
                repository: null,
                globalBox: mockBox,
              ),
          throwsAssertionError);
      expect(
          () => InitialSettingsCubit(
                globalBox: null,
                repository: mockInitialSettingsRepository,
              ),
          throwsAssertionError);
    });

    test('initial state is InitialSettingsInitial', () {
      expect(cubit.state is InitialSettingsInitial, true);
    });

    blocTest(
      '''WHEN validateServerName is called
         SHOULD emit InitialSettingsValidateServerLoad and InitialSettingsValidateServerSuccess when success
         AND should add info to GlobalBox
      ''',
      build: () {
        when(mockInitialSettingsRepository.fetchAllLocales('serverName'))
            .thenAnswer(
          (_) async => locales,
        );
        when(mockInitialSettingsRepository.authIdpDiscovery('serverName'))
            .thenAnswer(
          (_) async => Future.value(true),
        );
        return cubit;
      },
      act: (cubit) => cubit.validateServerName('serverName'),
      expect: [
        InitialSettingsValidateServerLoad(),
        InitialSettingsValidateServerSuccess(),
      ],
      verify: (cubit) {
        verify(mockInitialSettingsRepository.fetchAllLocales('serverName'))
            .called(1);
        verify(mockInitialSettingsRepository.authIdpDiscovery('serverName'))
            .called(1);
        verify(mockBox.put(SERVER, 'serverName')).called(1);
        verify(mockBox.put(ALL_LOCALES, jsonEncode(locales))).called(1);
      },
    );

    blocTest(
      '''WHEN validateServerName is called
         SHOULD emit InitialSettingsValidateServerLoad and InitialSettingsValidateServerFailure when GMServerException
      ''',
      build: () {
        when(mockInitialSettingsRepository.fetchAllLocales('serverName'))
            .thenThrow(GMServerException('error'));
        return cubit;
      },
      act: (cubit) => cubit.validateServerName('serverName'),
      expect: [
        InitialSettingsValidateServerLoad(),
        InitialSettingsValidateServerFailure('error'),
      ],
      verify: (cubit) {
        verify(mockInitialSettingsRepository.fetchAllLocales('serverName'))
            .called(1);
      },
    );
  });
}
