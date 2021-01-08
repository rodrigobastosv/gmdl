import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';

class PendingStopsTab extends StatelessWidget {
  const PendingStopsTab({Key key, this.stops}) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        'PENDING (${stops.length})',
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
