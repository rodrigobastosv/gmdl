import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cubit/route/route_cubit.dart';
import 'stop_list_view.dart';

class StopListPage extends StatelessWidget {
  const StopListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.watch<RouteCubit>(),
      child: const StopListView(),
    );
  }
}
