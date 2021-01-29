import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';
import 'package:gm_driver_lite/core/exception/exceptions.dart';
import 'package:mockito/mockito.dart';

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
         SHOULD emit [LoadingEquipment, EquipmentFound]
      ''',
      build: () {
        when(mockEquipmentRepository.getEquipment('equip'))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.getEquipmentInfo('equip'),
      expect: [
        LoadingEquipment(),
        EquipmentFound(),
      ],
    );

    blocTest(
      '''WHEN getEquipmentInfo is called
         AND it did throws EquipmentNotFoundException
         SHOULD emit [LoadingEquipment, EquipmentNotFound]
      ''',
      build: () {
        when(mockEquipmentRepository.getEquipment('equip'))
            .thenThrow(EquipmentNotFoundException());
        return cubit;
      },
      act: (cubit) => cubit.getEquipmentInfo('equip'),
      expect: [
        LoadingEquipment(),
        EquipmentNotFound('Equipment was not found'),
      ],
    );

    blocTest(
      '''WHEN getEquipmentInfo is called
         AND it did throws GMServerException
         SHOULD emit [LoadingEquipment, EquipmentNotFound]
      ''',
      build: () {
        when(mockEquipmentRepository.getEquipment('equip'))
            .thenThrow(GMServerException('server error'));
        return cubit;
      },
      act: (cubit) => cubit.getEquipmentInfo('equip'),
      expect: [
        LoadingEquipment(),
        EquipmentFailed('server error'),
      ],
    );
  });
}
