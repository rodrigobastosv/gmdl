import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/cubits.dart';
import '../../core/hive/boxes.dart';
import '../../core/repository/repositories.dart';
import 'load_route_view.dart';

class LoadRoutePage extends StatelessWidget {
  const LoadRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadRouteCubit>(
      create: (_) => LoadRouteCubit(
        repository: context.read<RouteRepository>(),
        driverBox: Hive.box(DRIVER_BOX),
      )..fetchRouteView(),
      child: const LoadRouteView(),
    );
  }
}
