import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/extension/i18n_cubit_extension.dart';

class DoneStopsTab extends StatelessWidget {
  const DoneStopsTab({Key key, this.stops}) : super(key: key);

  final List<StopModel> stops;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        '${context.getTextUppercase('route.tab.done')} (${stops.length})',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
      ),
    );
  }
}
