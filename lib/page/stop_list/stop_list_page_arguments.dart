import 'package:flutter/foundation.dart';

import '../../core/cubit/cubits.dart';

class StopListPageArguments {
  StopListPageArguments({
    @required this.routeCubit,
    @required this.hosCubit,
  });

  final RouteCubit routeCubit;
  final HosCubit hosCubit;
}
