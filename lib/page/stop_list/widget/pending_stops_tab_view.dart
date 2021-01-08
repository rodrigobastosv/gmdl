import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import 'stop_list_tile.dart';

class PendingStopsTabView extends StatelessWidget {
  const PendingStopsTabView({
    Key key,
    this.stops,
  }) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) => StopListTile(stops[i]),
      itemCount: stops.length,
    );
  }
}
