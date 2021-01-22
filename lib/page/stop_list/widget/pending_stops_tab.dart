import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/extension/i18n_cubit_extension.dart';

class PendingStopsTab extends StatelessWidget {
  const PendingStopsTab({Key key, this.stops}) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        '''${context.getTextUppercase('message.status.pending')} (${stops.length})''',
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
