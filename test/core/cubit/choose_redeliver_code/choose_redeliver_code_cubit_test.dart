import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';

void main() {
  ChooseRedeliverCodeCubit cubit;
  final redeliverCode = UndeliverableCodeModel(
    id: 1,
  );

  group('ChooseRedeliverCodeCubit', () {
    setUp(() {
      cubit = ChooseRedeliverCodeCubit();
    });

    test('initial state is ChooseCancelCodeInitial', () {
      expect(cubit.state is ChooseRedeliverCodeInitial, true);
    });

    test('pickedRedeliverableCode should start with no value', () {
      expect(cubit.pickedRedeliverableCode, isNull);
    });

    test(
        '''hasRedeliverableCodePicked should return true or false if any redeliver code was picked''',
        () {
      expect(cubit.hasRedeliverableCodePicked, false);
      cubit.pickRedeliverCode(redeliverCode);
      expect(cubit.hasRedeliverableCodePicked, true);
      cubit.unpickRedeliverCode(redeliverCode);
      expect(cubit.hasRedeliverableCodePicked, false);
    });

    blocTest(
      '''WHEN pickRedeliverCode is called
         SHOULD emit ChooseRedeliverCodePickCode with the same redeliver code picked
      ''',
      build: () => cubit,
      act: (cubit) => cubit.pickRedeliverCode(redeliverCode),
      expect: [
        ChooseRedeliverCodePickCode(redeliverCode),
      ],
    );

    blocTest(
      '''WHEN unpickRedeliverCode is called
         SHOULD emit ChooseRedeliverCodePickCode with null
      ''',
      build: () => cubit,
      act: (cubit) => cubit.unpickRedeliverCode(redeliverCode),
      expect: [
        ChooseRedeliverCodePickCode(null),
      ],
    );
  });
}
