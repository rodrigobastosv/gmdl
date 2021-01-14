import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/route/route_cubit.dart';
import '../../../core/entity/model/models.dart';
import 'done_stop_list_tile.dart';

class DoneStopsTabView extends StatelessWidget {
  const DoneStopsTabView({
    Key key,
    this.stops,
  }) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteCubit, RouteState>(
      buildWhen: (previousState, state) =>
          state is RouteUpdatedDueStopChange ||
          state is RouteUpdatedDueStopClone,
      builder: (_, state) => ListView.builder(
        itemBuilder: (_, i) => DoneStopListTile(stops[i]),
        itemCount: stops.length,
      ),
    );
  }
}
