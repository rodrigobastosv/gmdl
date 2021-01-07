import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../core/entity/model/models.dart';
import '../../core/repository/repositories.dart';
import 'route_at_glance_view.dart';

class RouteAtGlancePage extends StatelessWidget {
  const RouteAtGlancePage({
    Key key,
    this.route,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RouteCubit>(
      create: (_) => RouteCubit(
        route: route,
        repository: context.read<RouteRepository>(),
      ),
      child: const RouteAtGlanceView(),
    );
  }
}
