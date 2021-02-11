import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import '../../../mocks.dart';

void main() {
  ChooseEquipmentCubit cubit;
  MockEquipmentRepository mockEquipmentRepository;

  group('ChooseEquipmentCubit', () {
    setUpAll(() {
      mockEquipmentRepository = MockEquipmentRepository();
    });

    setUp(() {
      cubit = ChooseEquipmentCubit(mockEquipmentRepository);
    });

    test('asserts', () {
      expect(() => ChooseEquipmentCubit(null), throwsAssertionError);
    });

    test('initial state is ChooseEquipmentInitial', () {
      expect(cubit.state is ChooseEquipmentInitial, true);
    });

    blocTest(
      '''WHEN getEquipmentInfo is called
         AND it founds equipment
         SHOULD emit ChooseEquipmentLoad and ChooseEquipmentFound
      ''',
      build: () {
        when(mockEquipmentRepository.getEquipment('equip'))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.getEquipmentInfo('equip'),
      expect: [
        ChooseEquipmentLoad(),
        ChooseEquipmentFound(),
      ],
    );

    blocTest(
      '''WHEN getEquipmentInfo is called
         AND it did throws EquipmentNotFoundException
         SHOULD emit ChooseEquipmentLoad and ChooseEquipmentNotFound
      ''',
      build: () {
        when(mockEquipmentRepository.getEquipment('equip'))
            .thenThrow(EquipmentNotFoundException());
        return cubit;
      },
      act: (cubit) => cubit.getEquipmentInfo('equip'),
      expect: [
        ChooseEquipmentLoad(),
        ChooseEquipmentNotFound('Equipment was not found'),
      ],
    );

    blocTest(
      '''WHEN getEquipmentInfo is called
         AND it did throws GMServerException
         SHOULD emit ChooseEquipmentLoad and ChooseEquipmentFailure
      ''',
      build: () {
        when(mockEquipmentRepository.getEquipment('equip'))
            .thenThrow(GMServerException('server error'));
        return cubit;
      },
      act: (cubit) => cubit.getEquipmentInfo('equip'),
      expect: [
        ChooseEquipmentLoad(),
        ChooseEquipmentFailure('server error'),
      ],
    );
  });
}
