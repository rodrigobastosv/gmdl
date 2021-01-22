import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/extension/i18n_cubit_extension.dart';

class BasicRouteSummaryInfo extends StatelessWidget {
  const BasicRouteSummaryInfo({
    Key key,
    this.route,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          MdiIcons.pin,
          color: Theme.of(context).primaryColor,
          size: 14,
        ),
        Text(
          '${route.stops.length} ${context.getText('stopList.title')}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const Icon(
          MdiIcons.road,
          color: Color(0xFFFAA800),
          size: 14,
        ),
        const Text(
          '0 km',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const Icon(
          MdiIcons.clockEnd,
          color: Color(0xFFFAA800),
          size: 14,
        ),
        const Text(
          '0h 0m',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
