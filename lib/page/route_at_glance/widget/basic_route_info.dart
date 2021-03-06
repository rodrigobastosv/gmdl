import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/entity/model/models.dart';
import '../../../core/extension/i18n_cubit_extension.dart';
import '../../../core/utils/utils.dart';

class BasicRouteInfo extends StatelessWidget {
  const BasicRouteInfo({Key key, this.route}) : super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  context.getText('driver.routeAtGlance'),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                      ),
                ),
                Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Text(
                      route.key,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      '${route.date}',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 30,
              child: Row(
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        MdiIcons.pin,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      Text(
                        '''${route.stops.length} ${context.getText('stopList.title')}''',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: <Widget>[
                      Icon(
                        MdiIcons.road,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      Text(
                        '''${getPlannedDistanceInKm(route).toStringAsFixed(1)} km''',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: <Widget>[
                      Icon(
                        MdiIcons.clockEnd,
                        color: Theme.of(context).primaryColor,
                        size: 14,
                      ),
                      Text(
                        '${getPlannedServiceInHoursAndMinutes(route)}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
