import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../../core/entity/model/models.dart';

class RouteMap extends StatelessWidget {
  const RouteMap({
    Key key,
    @required this.route,
  })  : assert(route != null),
        super(key: key);

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
          route.origLatitude,
          route.origLongitude,
        ),
        zoom: 13,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
      ],
    );
  }
}
