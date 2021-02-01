import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/cubits.dart';
import '../../../core/entity/model/models.dart';
import 'stop_list_tile.dart';

class PendingStopsTabView extends StatelessWidget {
  const PendingStopsTabView({
    Key key,
    @required this.stops,
    @required this.isUsingPro,
  }) : super(key: key);

  final List<StopModel> stops;
  final bool isUsingPro;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteCubit, RouteState>(
      builder: (_, state) => ListView.builder(
        itemBuilder: (_, i) => Column(
          children: [
            StopListTile(
              stop: stops[i],
              isNextStopSuggested: i == 0,
              isUsingPro: isUsingPro,
              isBeginNextStops: i == 1,
            ),
            const Divider(
              thickness: 2,
              height: 4,
            ),
          ],
        ),
        itemCount: stops.length,
      ),
    );
  }
}
