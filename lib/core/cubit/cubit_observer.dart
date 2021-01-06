import 'package:flutter_bloc/flutter_bloc.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print(
        '${cubit.runtimeType}: ${change.currentState} -> ${change.nextState}');
    super.onChange(cubit, change);
  }
}
