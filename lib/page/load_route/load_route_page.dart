import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/global/global_info.dart';
import '../../core/repository/repositories.dart';
import 'load_route_view.dart';

class LoadRoutePage extends StatelessWidget {
  const LoadRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadRouteCubit>(
      create: (_) => LoadRouteCubit(
        repository: context.read<RouteRepository>(),
        globalInfo: context.read<GlobalInfo>(),
        i18nCubit: context.read<I18nCubit>(),
      )..fetchRouteInformation(),
      child: const LoadRouteView(),
    );
  }
}
