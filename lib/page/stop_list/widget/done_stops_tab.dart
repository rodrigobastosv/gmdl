import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';

class DoneStopsTab extends StatelessWidget {
  const DoneStopsTab({Key key, this.stops}) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        'DONE (${stops.length})',
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
