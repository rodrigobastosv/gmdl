import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/constants.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import 'package:gm_driver_lite/core/entity/enum/enums.dart';
import '../../../mocks.dart';

void main() {
  LoadInfoCubit cubit;
  MockLoadingInfoRepository mockLoadingInfoRepository;
  MockGlobalInfo mockGlobalInfo;
  MockI18nCubit mockI18nCubit;
  MockDeviceInfoService mockDeviceInfoService;
  MockPackageInfoService mockPackageInfoService;

  group('InitialSettingsCubit', () {
    setUpAll(() {
      mockLoadingInfoRepository = MockLoadingInfoRepository();
      mockGlobalInfo = MockGlobalInfo();
      mockI18nCubit = MockI18nCubit();
      mockDeviceInfoService = MockDeviceInfoService();
      mockPackageInfoService = MockPackageInfoService();
    });

    setUp(() {
      cubit = LoadInfoCubit(
        repository: mockLoadingInfoRepository,
        globalInfo: mockGlobalInfo,
        i18nCubit: mockI18nCubit,
        deviceInfoService: mockDeviceInfoService,
        packageInfoService: mockPackageInfoService,
      );
    });

    test('asserts', () {
      expect(
          () => LoadInfoCubit(
                repository: null,
                globalInfo: mockGlobalInfo,
                i18nCubit: mockI18nCubit,
                deviceInfoService: mockDeviceInfoService,
                packageInfoService: mockPackageInfoService,
              ),
          throwsAssertionError);
      expect(
          () => LoadInfoCubit(
                repository: mockLoadingInfoRepository,
                globalInfo: null,
                i18nCubit: mockI18nCubit,
                deviceInfoService: mockDeviceInfoService,
                packageInfoService: mockPackageInfoService,
              ),
          throwsAssertionError);
      expect(
          () => LoadInfoCubit(
                repository: mockLoadingInfoRepository,
                globalInfo: mockGlobalInfo,
                i18nCubit: null,
                deviceInfoService: mockDeviceInfoService,
                packageInfoService: mockPackageInfoService,
              ),
          throwsAssertionError);
      expect(
          () => LoadInfoCubit(
                repository: mockLoadingInfoRepository,
                globalInfo: mockGlobalInfo,
                i18nCubit: mockI18nCubit,
                deviceInfoService: null,
                packageInfoService: mockPackageInfoService,
              ),
          throwsAssertionError);
      expect(
          () => LoadInfoCubit(
                repository: mockLoadingInfoRepository,
                globalInfo: mockGlobalInfo,
                i18nCubit: mockI18nCubit,
                deviceInfoService: mockDeviceInfoService,
                packageInfoService: null,
              ),
          throwsAssertionError);
    });

    test('initial state is LoadingInitial', () {
      expect(cubit.state is LoadingInitial, true);
    });

    blocTest(
      '''WHEN getDriverInfo is called
         SHOULD emit Loading states and AllInfoLoadedSuccess at the end
         AND should store all the information on GlobalInfo
      ''',
      build: () {
        when(mockI18nCubit.getFormattedText('driver.loading.data'))
            .thenReturn('driver.loading.data');
        when(mockI18nCubit.getFormattedText('push.registerDeviceOnServer'))
            .thenReturn('push.registerDeviceOnServer');
        when(mockI18nCubit.getFormattedText('push.bindModule'))
            .thenReturn('push.bindModule');
        when(mockI18nCubit.getFormattedText('push.registerDeviceOnServer'))
            .thenReturn('push.registerDeviceOnServer');
        when(mockI18nCubit.getFormattedText('Locale.list'))
            .thenReturn('Locale.list');
        when(mockI18nCubit
                .getFormattedText('loading.downloading.configurations'))
            .thenReturn('loading.downloading.configurations');
        when(mockI18nCubit.getFormattedText('loading.downloading.reasonCodes'))
            .thenReturn('loading.downloading.reasonCodes');
        when(mockLoadingInfoRepository.getDriverInfo(username: 'driver'))
            .thenAnswer(
          (_) async => DriverInfoDto(
            id: 1,
            driverType: DriverType.DEFAULT,
            enabled: true,
            login: 'driver',
            name: 'driver',
          ),
        );
        when(mockDeviceInfoService.getId()).thenReturn('1');
        when(mockDeviceInfoService.getModel()).thenReturn('myModel');
        when(mockPackageInfoService.getVersion()).thenReturn('1.0.0');
        when(
          mockLoadingInfoRepository.registerDevice(
            deviceModel: 'myModel',
            uniqueDeviceId: '1',
            platformVersion: '1.0.0',
            platform: 'IOS',
          ),
        ).thenAnswer(
          (_) async => MobileDeviceDto(
            id: 1,
          ),
        );
        when(mockLoadingInfoRepository.bindModule(
          deviceId: 1,
          appVersion: '1.0.0',
          moduleKey: moduleKey,
        )).thenAnswer((_) => Future.value());
        when(mockLoadingInfoRepository.logDevice(
          userId: 1,
          deviceId: 1,
        )).thenAnswer((_) => Future.value());
        when(mockI18nCubit.fetchResources()).thenAnswer((_) async => []);
        when(mockLoadingInfoRepository.getGlobalConfigurations())
            .thenAnswer((_) async => GlobalConfigurationsDto());
        when(mockLoadingInfoRepository.getUserConfigurations())
            .thenAnswer((_) async => {});
        when(mockLoadingInfoRepository.fetchCancelCodes())
            .thenAnswer((_) async => []);
        when(mockLoadingInfoRepository.fetchUndeliverableCodes())
            .thenAnswer((_) async => []);
        return cubit;
      },
      act: (cubit) => cubit.getDriverInfo('driver'),
      expect: [
        InfoLoading('driver.loading.data'),
        BasicDriverInfoSuccess(),
        InfoLoading('push.registerDeviceOnServer'),
        RegisterDeviceSuccess(1),
        InfoLoading('push.bindModule'),
        InfoLoading('push.registerDeviceOnServer'),
        RegisterDeviceSuccess(1),
        InfoLoading('Locale.list'),
        FetchResourcesSuccess(),
        InfoLoading('loading.downloading.configurations'),
        FetchGlobalConfigSuccess(),
        FetchUserConfigSuccess(),
        InfoLoading('loading.downloading.reasonCodes'),
        FetchCancelCodesSuccess(),
        FetchUndeliverableCodesSuccess(),
        AllInfoLoadedSuccess(),
      ],
      verify: (cubit) {
        verify(
          mockGlobalInfo.storeGeneralInfo(
            driverInfo: DriverInfoDto(
              id: 1,
              driverType: DriverType.DEFAULT,
              enabled: true,
              login: 'driver',
              name: 'driver',
            ),
            mobileDevice: MobileDeviceDto(
              id: 1,
            ),
            globalConfigurations: GlobalConfigurationsDto(),
            userConfigurations: {},
            cancelCodes: [],
            undeliverableCodes: [],
          ),
        );
      },
    );

    blocTest(
      '''WHEN getDriverInfo is called
         SHOULD emit DriverInfoFailed state when theres an exception
      ''',
      build: () {
        when(mockI18nCubit.getFormattedText('driver.loading.data'))
            .thenReturn('driver.loading.data');
        when(mockLoadingInfoRepository.getDriverInfo(username: 'driver'))
            .thenThrow(Exception());
        return cubit;
      },
      act: (cubit) => cubit.getDriverInfo('driver'),
      expect: [
        InfoLoading('driver.loading.data'),
        DriverInfoFailed(),
      ],
    );
  });
}
