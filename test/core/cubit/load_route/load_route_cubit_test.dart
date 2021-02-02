import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import '../../../mocks.dart';

void main() {
  LoadRouteCubit cubit;
  MockRouteRepository mockRouteRepository;
  MockGlobalInfo mockGlobalInfo;
  MockI18nCubit mockI18nCubit;

  group('InitialSettingsCubit', () {
    setUpAll(() {
      mockRouteRepository = MockRouteRepository();
      mockGlobalInfo = MockGlobalInfo();
      mockI18nCubit = MockI18nCubit();
    });

    setUp(() {
      cubit = LoadRouteCubit(
        repository: mockRouteRepository,
        globalInfo: mockGlobalInfo,
        i18nCubit: mockI18nCubit,
      );
    });

    test('asserts', () {
      expect(
          () => LoadRouteCubit(
                repository: null,
                globalInfo: mockGlobalInfo,
                i18nCubit: mockI18nCubit,
              ),
          throwsAssertionError);
      expect(
          () => LoadRouteCubit(
                repository: mockRouteRepository,
                globalInfo: null,
                i18nCubit: mockI18nCubit,
              ),
          throwsAssertionError);
      expect(
          () => LoadRouteCubit(
                repository: mockRouteRepository,
                globalInfo: mockGlobalInfo,
                i18nCubit: null,
              ),
          throwsAssertionError);
    });

    test('initial state is RouteAtGlanceInitial', () {
      expect(cubit.state is RouteAtGlanceInitial, true);
    });

    blocTest(
      '''WHEN fetchRouteInformation is called
         SHOULD emit Loading state and RouteLoadedSuccess at the end
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenReturn(
          DriverInfoDto(login: 'driver'),
        );
        when(mockI18nCubit.getFormattedText('loading.downloading.route'))
            .thenReturn('loading.downloading.route');
        when(mockRouteRepository.fetchRouteView('driver')).thenAnswer(
          (_) async => RouteViewInfoDTO(
            route: RouteDTO(id: 1),
          ),
        );
        when(mockRouteRepository.fetchRoute(1)).thenAnswer(
          (_) async => {
            'featureStates': [],
            'route': {
              'id': 1,
            },
          },
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchRouteInformation(),
      expect: [
        const LoadingInfo('loading.downloading.route'),
        RouteLoadedSuccess(
          RouteModel.fromJson({
            'id': 1,
          }),
        ),
      ],
      verify: (cubit) {
        verify(mockRouteRepository.fetchRouteView('driver')).called(1);
        verify(mockRouteRepository.fetchRoute(1)).called(1);
      },
    );

    blocTest(
      '''WHEN fetchRouteInformation throws NoneRouteFoundException 
         SHOULD emit Loading state and RouteLoadFailed at the end
      ''',
      build: () {
        when(mockGlobalInfo.driverInfo).thenReturn(
          DriverInfoDto(login: 'driver'),
        );
        when(mockI18nCubit.getFormattedText('loading.downloading.route'))
            .thenReturn('loading.downloading.route');
        when(mockRouteRepository.fetchRouteView('driver'))
            .thenThrow(NoneRouteFoundException());
        return cubit;
      },
      act: (cubit) => cubit.fetchRouteInformation(),
      expect: [
        const LoadingInfo('loading.downloading.route'),
        RouteLoadFailed('loader.routes.not.found'),
      ],
      verify: (cubit) {
        verify(mockRouteRepository.fetchRouteView('driver')).called(1);
      },
    );
  });
}
