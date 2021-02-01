import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/locale_model.dart';
import 'package:gm_driver_lite/core/global/hive.dart';
import '../../../mocks.dart';

void main() {
  I18nCubit cubit;
  MockI18nRepository mockI18nRepository;
  MockBox mockBox;

  group('I18nCubit', () {
    setUp(() {
      mockI18nRepository = MockI18nRepository();
      mockBox = MockBox();
      cubit = I18nCubit(
        repository: mockI18nRepository,
        globalBox: mockBox,
      );
    });

    test('asserts', () {
      expect(
          () => I18nCubit(
                repository: null,
                globalBox: mockBox,
              ),
          throwsAssertionError);
      expect(
          () => I18nCubit(
                globalBox: null,
                repository: mockI18nRepository,
              ),
          throwsAssertionError);
    });

    test('initial state is I18nInitial', () {
      expect(cubit.state is I18nInitial, true);
    });

    blocTest(
      '''WHEN initI18nInfo is called
         SHOULD populate locales and resources
      ''',
      build: () {
        when(mockBox.get(ALL_LOCALES)).thenReturn('');
        when(mockBox.get(LOCALE_KEY)).thenReturn('en');
        return cubit;
      },
      act: (cubit) => cubit.initI18nInfo(),
      expect: [],
    );

    test('getAllLocales should return a list of locales', () {
      cubit.initI18nInfo();
      expect(cubit.getAllLocales() is List, true);
    });

    test('should populate allLocales', () {
      when(mockBox.get(ALL_LOCALES)).thenReturn(
        jsonEncode(
          [
            LocaleModel(id: 1),
            LocaleModel(id: 2),
            LocaleModel(id: 3),
          ],
        ),
      );
      cubit.initI18nInfo();
      expect(cubit.getAllLocales(), isNotEmpty);
    });

    blocTest(
      '''WHEN changeLocale is called
         SHOULD emit LocaleChanged with localeKey
      ''',
      build: () => cubit,
      act: (cubit) {
        cubit.changeLocale('pt');
        cubit.changeLocale('en');
      },
      expect: [
        const LocaleChanged('pt'),
        const LocaleChanged('en'),
      ],
    );

    blocTest(
      '''WHEN fetchResources is called
         SHOULD emit ResourcesFetchSuccess when success
      ''',
      build: () {
        when(mockI18nRepository.fetchResources('en'))
            .thenAnswer((_) async => []);
        cubit.localeKey = 'en';
        return cubit;
      },
      act: (cubit) {
        cubit.initI18nInfo();
        cubit.fetchResources();
      },
      expect: [
        ResourcesFetchSuccess(),
      ],
      verify: (cubit) {
        verify(mockI18nRepository.fetchResources('en')).called(1);
      },
    );

    blocTest(
      '''WHEN fetchResources is called
         SHOULD emit ResourcesFetchFailed when fail
      ''',
      build: () {
        when(mockI18nRepository.fetchResources('en')).thenThrow(Exception());
        cubit.localeKey = 'en';
        return cubit;
      },
      act: (cubit) {
        cubit.initI18nInfo();
        cubit.fetchResources();
      },
      expect: [
        ResourcesFetchFailed(),
      ],
      verify: (cubit) {
        verify(mockI18nRepository.fetchResources('en')).called(1);
      },
    );

    test('getFormattedText should get the text from desired resources', () {
      cubit.localeKey = 'en';
      cubit.initI18nInfo();
      expect(cubit.getFormattedText('general.server'), 'Server');
      cubit.changeLocale('pt');
      expect(cubit.getFormattedText('general.server'), 'Servidor');
    });
  });
}
