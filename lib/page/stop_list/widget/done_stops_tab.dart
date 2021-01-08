import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';

class DoneStopsTab extends StatelessWidget {
  const DoneStopsTab({Key key, this.stops}) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return const Tab(
      child: Text(
        'DONE (0)',
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
