import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';

import '../../../core/entity/model/models.dart';

class BasicRouteInfo extends StatelessWidget {
  const BasicRouteInfo({Key key, this.route}) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFF24242A),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'ROUTE AT GLANCE',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                  ),
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Text(
                      route.key,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${route.date}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Ionicons.ios_pin,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  '${route.stops.length} Stops',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
