import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import 'pending_stop_list_tile.dart';

class PendingStopsTabView extends StatelessWidget {
  const PendingStopsTabView({
    Key key,
    this.stops,
  }) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteCubit, RouteState>(
      builder: (_, state) => ListView.builder(
        itemBuilder: (_, i) => PendingStopListTile(stops[i]),
        itemCount: stops.length,
      ),
    );
  }
}
