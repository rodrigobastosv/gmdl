import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';

void main() {
  ChooseCancelCodeCubit cubit;
  final cancelCode = CancelCodeModel(
    id: 1,
  );

  group('ChooseCancelCodeCubit', () {
    setUp(() {
      cubit = ChooseCancelCodeCubit();
    });

    test('initial state is ChooseCancelCodeInitial', () {
      expect(cubit.state is ChooseCancelCodeInitial, true);
    });

    test('pickedCancelCode should start with no value', () {
      expect(cubit.pickedCancelCode, isNull);
    });

    test(
        '''hasCancelCodePicked should return true or false if any cancel code was picked''',
        () {
      expect(cubit.hasCancelCodePicked, false);
      cubit.pickCancelCode(cancelCode);
      expect(cubit.hasCancelCodePicked, true);
      cubit.unpickCancelCode(cancelCode);
      expect(cubit.hasCancelCodePicked, false);
    });

    blocTest(
      '''WHEN pickCancelCode is called
         SHOULD emit CancelCodePicked with the same cancel code picked
      ''',
      build: () => cubit,
      act: (cubit) => cubit.pickCancelCode(cancelCode),
      expect: [
        CancelCodePicked(cancelCode),
      ],
    );

    blocTest(
      '''WHEN unpickCancelCode is called
         SHOULD emit CancelCodePicked with null
      ''',
      build: () => cubit,
      act: (cubit) => cubit.unpickCancelCode(cancelCode),
      expect: [
        CancelCodePicked(null),
      ],
    );
  });
}
