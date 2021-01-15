import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/cubits.dart';
import '../../core/cubit/stop/stop_cubit.dart';
import '../../core/entity/model/models.dart';
import '../../core/repository/repositories.dart';
import '../../core/store/store_provider.dart';
import 'stop_view.dart';

class StopPage extends StatelessWidget {
  const StopPage({Key key, this.stop})
      : assert(stop != null),
        super(key: key);

  final StopModel stop;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopCubit>(
      create: (_) => StopCubit(
        stop: stop,
        repository: context.read<StopRepository>(),
        routeCubit: context.read<RouteCubit>(),
        storeProvider: context.read<StoreProvider>(),
      ),
      child: const StopView(),
    );
  }
}