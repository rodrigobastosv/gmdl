import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../core/cubit/route_at_glance/route_at_glance_cubit.dart';
import '../../core/hive/boxes.dart';
import '../../core/repository/repositories.dart';
import 'loading_route_view.dart';

class LoadingRoutePage extends StatelessWidget {
  const LoadingRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RouteAtGlanceCubit>(
      create: (_) => RouteAtGlanceCubit(
        repository: context.read<RouteRepository>(),
        driverBox: Hive.box(DRIVER_BOX),
      )..fetchRouteView(),
      child: const LoadingRouteView(),
    );
  }
}
