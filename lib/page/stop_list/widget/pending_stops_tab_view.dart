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
    this.term,
  }) : super(key: key);

  final List<StopModel> stops;
  final bool isUsingPro;
  final String term;

  @override
  Widget build(BuildContext context) {
    final filteredStops = stops.where((stop) {
      final description = stop?.location?.description ?? '';
      return description.contains(term);
    }).toList();
    return BlocBuilder<RouteCubit, RouteState>(
      builder: (_, state) => ListView.builder(
        itemBuilder: (_, i) => Column(
          children: [
            StopListTile(
              stop: filteredStops[i],
              isNextStopSuggested: i == 0,
              isUsingPro: isUsingPro,
              isBeginNextStops: i == 1,
            ),
            const Divider(
              thickness: 1,
              height: 3,
            ),
          ],
        ),
        itemCount: filteredStops.length,
      ),
    );
  }
}
