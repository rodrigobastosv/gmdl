import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/cubit/cubits.dart';

void main() {
  StopSearchCubit cubit;

  group('StopSearchCubit', () {
    setUp(() {
      cubit = StopSearchCubit();
    });

    test('initial state is StopSearchInitial', () {
      expect(cubit.state is StopSearchInitial, true);
    });

    blocTest(
      '''WHEN onChangeSearchTerm
         SHOULD emit SearchTermChanged
      ''',
      build: () => cubit,
      act: (cubit) {
        cubit.onChangeSearchTerm('a');
        cubit.onChangeSearchTerm('ab');
        cubit.onChangeSearchTerm('a');
        cubit.onChangeSearchTerm('');
      },
      expect: [
        SearchTermChanged('a'),
        SearchTermChanged('ab'),
        SearchTermChanged('a'),
        SearchTermChanged(''),
      ],
    );
  });
}
