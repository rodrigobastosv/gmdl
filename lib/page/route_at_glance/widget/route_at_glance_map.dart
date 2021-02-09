import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import '../../../core/cubit/cubits.dart';
import '../../../core/utils/map_utils.dart';
import 'package:latlong/latlong.dart';

class RouteAtGlanceMap extends StatelessWidget {
  const RouteAtGlanceMap({
    Key key,
    @required this.routeCubit,
  })  : assert(routeCubit != null),
        super(key: key);

  final RouteCubit routeCubit;

  @override
  Widget build(BuildContext context) {
    final route = routeCubit.route;
    final lastPosition = routeCubit.lastPosition;
    final routePath = route.routePath;
    return FlutterMap(
      key: UniqueKey(),
      options: MapOptions(
        center: LatLng(
          lastPosition.latitude,
          lastPosition.longitude,
        ),
        zoom: DEFAULT_MAP_ZOOM,
      ),
      layers: [
        tileOptions,
        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: decodeEncodedPath(routePath),
              strokeWidth: DEFAULT_POLYLINE_WIDTH,
              color: PLANNED_PATH_COLOR,
            ),
          ],
        ),
        MarkerLayerOptions(
          markers: [
            getMarkerOnPosition(lastPosition),
            ...getStopMarkers(route.stops),
          ],
        ),
      ],
    );
  }
}
