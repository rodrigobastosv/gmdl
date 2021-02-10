import '../../core/cubit/cubits.dart';
import '../../core/entity/model/models.dart';

class StopPageArguments {
  StopPageArguments({
    this.stop,
    this.routeCubit,
  });

  final StopModel stop;
  final RouteCubit routeCubit;
}
