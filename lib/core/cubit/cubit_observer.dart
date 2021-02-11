import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/utils.dart';

class CubitObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print(
        '''$INFO${cubit.runtimeType}: ${change.currentState} -> ${change.nextState}$RESET''');
    super.onChange(cubit, change);
  }

  @override
  void onCreate(Cubit cubit) {
    print('${SUCCESS}Creating ${cubit.runtimeType}$RESET');
    super.onCreate(cubit);
  }

  @override
  void onClose(Cubit cubit) {
    print('${WARNING}Closing ${cubit.runtimeType}$RESET');
    super.onClose(cubit);
  }
}
