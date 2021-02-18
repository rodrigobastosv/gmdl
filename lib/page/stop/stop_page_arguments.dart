import 'package:flutter/foundation.dart';

import '../../core/cubit/cubits.dart';
import '../../core/entity/model/models.dart';

class StopPageArguments {
  StopPageArguments({
    @required this.stop,
    @required this.routeCubit,
  })  : assert(stop != null),
        assert(routeCubit != null);

  final StopModel stop;
  final RouteCubit routeCubit;
}
