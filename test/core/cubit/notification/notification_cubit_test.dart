import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import '../../../mocks.dart';

void main() {
  NotificationCubit cubit;
  MockFirebaseMessaging mockFirebaseMessaging;
  MockNotificationRepository mockNotificationRepository;
  MockGlobalInfo mockGlobalInfo;

  final tokensStream = Stream.fromIterable(
    [
      'token1',
      'token2',
    ],
  );

  group('InitialSettingsCubit', () {
    setUpAll(() {
      mockFirebaseMessaging = MockFirebaseMessaging();
      mockNotificationRepository = MockNotificationRepository();
      mockGlobalInfo = MockGlobalInfo();
    });

    setUp(() {
      cubit = NotificationCubit(
        firebaseMessaging: mockFirebaseMessaging,
        repository: mockNotificationRepository,
        globalInfo: mockGlobalInfo,
      );
    });

    test('asserts', () {
      expect(
          () => NotificationCubit(
                firebaseMessaging: null,
                repository: mockNotificationRepository,
                globalInfo: mockGlobalInfo,
              ),
          throwsAssertionError);
      expect(
          () => NotificationCubit(
                firebaseMessaging: mockFirebaseMessaging,
                repository: null,
                globalInfo: mockGlobalInfo,
              ),
          throwsAssertionError);
      expect(
          () => NotificationCubit(
                firebaseMessaging: mockFirebaseMessaging,
                repository: mockNotificationRepository,
                globalInfo: null,
              ),
          throwsAssertionError);
    });

    test('initial state is NotificationInitial', () {
      expect(cubit.state is NotificationInitial, true);
    });

    blocTest(
      '''WHEN initNotifications is called
         SHOULD call updateToken
         AND listen to new messages
         AND listen to onTokenRefresh events
      ''',
      build: () {
        when(mockFirebaseMessaging.getToken())
            .thenAnswer((_) async => 'myToken');
        when(mockFirebaseMessaging.onTokenRefresh).thenAnswer(
          (_) => tokensStream,
        );
        when(mockGlobalInfo.mobileDevice).thenReturn(
          MobileDeviceDto(
            id: 1,
          ),
        );
        when(
          mockNotificationRepository.updateToken(
            deviceId: 1,
            token: 'myToken',
          ),
        ).thenAnswer((_) async => Future.value());
        return cubit;
      },
      act: (cubit) => cubit.initNotifications(),
      expect: [
        NotificationSetupSuccess('myToken'),
        NotificationTokenRefreshed('token1'),
        NotificationTokenRefreshed('token2'),
      ],
      verify: (cubit) {
        verify(mockFirebaseMessaging.getToken()).called(1);
        verify(
          mockNotificationRepository.updateToken(
            deviceId: 1,
            token: 'myToken',
          ),
        ).called(1);
      },
    );

    blocTest(
      '''WHEN initNotifications throws Exception
         SHOULD emit NotificationSetupFailed
      ''',
      build: () {
        when(mockFirebaseMessaging.getToken()).thenThrow(Exception());
        return cubit;
      },
      act: (cubit) => cubit.initNotifications(),
      expect: [
        NotificationSetupFailed(),
      ],
    );
  });
}
