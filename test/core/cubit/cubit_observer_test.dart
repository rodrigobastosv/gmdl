import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gm_driver_lite/core/cubit/cubit_observer.dart';
import 'package:gm_driver_lite/core/cubit/cubits.dart';

void main() {
  setUp(() => Bloc.observer = CubitObserver());

  test('CubitObserver', () {
    final cubit = ChooseCancelCodeCubit();
    cubit.onChange(
      Change<ChooseCancelCodeState>(
        currentState: ChooseCancelCodeInitial(),
        nextState: ChooseCancelCodePickCode(null),
      ),
    );
    cubit.close();
  });
}
