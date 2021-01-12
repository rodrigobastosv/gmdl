import 'package:flutter/material.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/utils/date_utils.dart';

class RouteSummaryHeaderInfo extends StatelessWidget {
  const RouteSummaryHeaderInfo({
    Key key,
    this.route,
  }) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODAY\'S SUMMARY',
          style: TextStyle(
            color: Color(0xFFB0D25A),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${route.key} - ${route.description}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              getBasicDateMonthDay(route.date),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
