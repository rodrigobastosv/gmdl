import 'package:flutter/foundation.dart';

import '../../core/cubit/cubits.dart';
import '../../core/entity/model/models.dart';

class StopPageArguments {
  StopPageArguments({
    @required this.stop,
    @required this.routeCubit,
    @required this.hosCubit,
  });

  final StopModel stop;
  final RouteCubit routeCubit;
  final HosCubit hosCubit;
}
