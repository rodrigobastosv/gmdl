import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import '../../../mocks.dart';

void main() {
  ConnectivityCubit cubit;
  MockConnectivity mockConnectivity;

  group('ConnectivityCubit', () {
    setUp(() {
      mockConnectivity = MockConnectivity();
      cubit = ConnectivityCubit(
        connectivity: mockConnectivity,
      );
    });

    test('asserts', () {
      expect(() => ConnectivityCubit(connectivity: null), throwsAssertionError);
    });

    test('initial state is ConnectivityHasConnection', () {
      expect(cubit.state is ConnectivityHasConnection, true);
    });

    blocTest(
      '''WHEN intiConnectionListener is fired
         SHOULD start listening to connectivity events
      ''',
      build: () {
        when(mockConnectivity.onConnectivityChanged).thenAnswer(
          (_) => Stream<ConnectivityResult>.fromFutures([
            Future.value(ConnectivityResult.wifi),
            Future.value(ConnectivityResult.none),
            Future.value(ConnectivityResult.mobile),
            Future.value(ConnectivityResult.wifi),
            Future.value(ConnectivityResult.none),
            Future.value(ConnectivityResult.none),
          ]),
        );
        return cubit;
      },
      act: (cubit) => cubit.intiConnectionListener(),
      expect: [
        ConnectivityHasConnection(false),
      ],
    );
  });
}
