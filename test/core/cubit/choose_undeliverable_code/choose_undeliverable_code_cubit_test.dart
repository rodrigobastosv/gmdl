import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';

void main() {
  ChooseUndeliverableCodeCubit cubit;
  final undeliverableCode = UndeliverableCodeModel(
    id: 1,
  );

  group('ChooseUndeliverableCodeCubit', () {
    setUp(() {
      cubit = ChooseUndeliverableCodeCubit();
    });

    test('initial state is ChooseUndeliverableCodeInitial', () {
      expect(cubit.state is ChooseUndeliverableCodeInitial, true);
    });

    test('pickedUndeliverableCode should start with no value', () {
      expect(cubit.pickedUndeliverableCode, isNull);
    });

    test(
        '''hasUndeliverableCodePicked should return true or false if any redeliver code was picked''',
        () {
      expect(cubit.hasUndeliverableCodePicked, false);
      cubit.pickUndeliverableCode(undeliverableCode);
      expect(cubit.hasUndeliverableCodePicked, true);
      cubit.unpickUndeliverableCode(undeliverableCode);
      expect(cubit.hasUndeliverableCodePicked, false);
    });

    blocTest(
      '''WHEN pickUndeliverableCode is called
         SHOULD emit RedeliverCodePicked with the same redeliver code picked
      ''',
      build: () => cubit,
      act: (cubit) => cubit.pickUndeliverableCode(undeliverableCode),
      expect: [
        UndeliverableCodePicked(undeliverableCode),
      ],
    );

    blocTest(
      '''WHEN unpickUndeliverableCode is called
         SHOULD emit CancelCodePicked with null
      ''',
      build: () => cubit,
      act: (cubit) => cubit.unpickUndeliverableCode(undeliverableCode),
      expect: [
        UndeliverableCodePicked(null),
      ],
    );
  });
}
