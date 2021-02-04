import 'package:flutter_bloc/flutter_bloc.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print(
        '${cubit.runtimeType}: ${change.currentState} -> ${change.nextState}');
    super.onChange(cubit, change);
  }

  @override
  void onCreate(Cubit cubit) {
    print('Creating ${cubit.runtimeType}');
    super.onCreate(cubit);
  }

  @override
  void onClose(Cubit cubit) {
    print('Closing ${cubit.runtimeType}');
    super.onClose(cubit);
  }
}
