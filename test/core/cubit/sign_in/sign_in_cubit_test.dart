import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/dto/dtos.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:gm_driver_lite/core/global/hive.dart';
import 'package:gm_driver_lite/core/utils/utils.dart';
import '../../../mocks.dart';

void main() {
  SignInCubit cubit;
  MockSignInRepository mockSignInRepository;
  MockBox mockBox;

  group('SignInCubit', () {
    setUp(() {
      mockSignInRepository = MockSignInRepository();
      mockBox = MockBox();
      cubit = SignInCubit(
        repository: mockSignInRepository,
        globalBox: mockBox,
      );
    });

    test('asserts', () {
      expect(
          () => SignInCubit(
                repository: null,
                globalBox: mockBox,
              ),
          throwsAssertionError);
      expect(
          () => SignInCubit(
                repository: mockSignInRepository,
                globalBox: null,
              ),
          throwsAssertionError);
    });

    test('initial state is SignInInitial', () {
      expect(cubit.state is SignInInitial, true);
    });

    group('signInUser', () {
      blocTest(
        '''WHEN signInUser is called
           SHOULD emit SignInLoad and SignInSuccess when success
           AND should add sign in info to GlobalBox
        ''',
        build: () {
          when(mockSignInRepository.signInUser(
            username: 'username',
            password: 'password',
          )).thenAnswer(
            (_) async => {
              'targetUrl': 'targetUrl',
              'message': 'message',
              'jsessionid': 'jsessionid',
              'resourceKey': 'resourceKey',
            },
          );
          return cubit;
        },
        act: (cubit) => cubit.signInUser(
          username: 'username',
          password: 'password',
        ),
        expect: [
          SignInLoad(),
          SignInSuccess(
            LoginResultDTO.fromJson(
              'username',
              {
                'targetUrl': 'targetUrl',
                'message': 'message',
                'jsessionid': 'jsessionid',
                'resourceKey': 'resourceKey',
              },
            ),
          ),
        ],
        verify: (cubit) {
          verify(mockBox.put(USERNAME, 'username')).called(1);
          verify(mockBox.put(PASSWORD, encodeString('password'))).called(1);
          verify(mockBox.put(TOKEN, any)).called(1);
        },
      );

      blocTest(
        '''WHEN signInUser is called
           SHOULD emit SignInLoad and UserSigningFailure when fails
        ''',
        build: () {
          when(mockSignInRepository.signInUser(
            username: 'username',
            password: 'password',
          )).thenThrow(SignInException('error'));
          return cubit;
        },
        act: (cubit) => cubit.signInUser(
          username: 'username',
          password: 'password',
        ),
        expect: [
          SignInLoad(),
          SignInFailure('error'),
        ],
        verify: (cubit) {
          verifyNever(mockBox.put(USERNAME, 'username'));
          verifyNever(mockBox.put(PASSWORD, encodeString('password')));
          verifyNever(mockBox.put(TOKEN, any));
        },
      );
    });
  });
}
