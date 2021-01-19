import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/repository/repositories.dart';
import '../../core/store/store.dart';
import 'load_route_view.dart';

class LoadRoutePage extends StatelessWidget {
  const LoadRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadRouteCubit>(
      create: (_) => LoadRouteCubit(
        repository: context.read<RouteRepository>(),
        store: context.read<Store>(),
      )..fetchRouteInformation(),
      child: const LoadRouteView(),
    );
  }
}
