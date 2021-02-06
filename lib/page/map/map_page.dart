import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import '../../core/cubit/route/route_cubit.dart';
import '../../core/entity/model/models.dart';
import '../../core/extension/extensions.dart';
import '../../core/utils/map_utils.dart';
import '../../widget/general/gm_scaffold.dart';
import 'widget/map_stop_marker.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeCubit = context.watch<RouteCubit>();
    final route = routeCubit.route;
    final stops = route.stops;
    final lastPosition = routeCubit.lastPosition;
    final routePath = route.routePath;
    return BlocBuilder<RouteCubit, RouteState>(
      builder: (_, state) => GMScaffold(
        withAppBar: false,
        body: Scaffold(
          body: FlutterMap(
            options: MapOptions(
              center: LatLng(
                lastPosition.latitude,
                lastPosition.longitude,
              ),
              zoom: 13,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  _getCurrentPositionMarker(lastPosition),
                  ..._getStopMarkers(stops),
                ],
              ),
              PolylineLayerOptions(
                polylines: [
                  Polyline(
                    points: decodeEncodedPath(routePath),
                    strokeWidth: 2,
                    color: const Color(0xFF800080),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'locate-vehicle',
            backgroundColor: Colors.white,
            child: SvgPicture.asset('assets/icons/map-locate-vehicle.svg'),
            onPressed: () {},
          ),
        ),
        mainButtonLabel:
            context.getTextUppercase('driver.forro.map.seestoplist'),
        mainButtonIcon: const Icon(Icons.list),
        mainButtonAction: () => Navigator.of(context).pop(),
      ),
    );
  }

  Marker _getCurrentPositionMarker(Position lastPosition) {
    return Marker(
      width: 30,
      height: 30,
      point: LatLng(
        lastPosition.latitude,
        lastPosition.longitude,
      ),
      builder: (_) => SvgPicture.asset(
        'assets/icons/map-current-position.svg',
      ),
    );
  }

  List<Marker> _getStopMarkers(List<StopModel> stops) {
    return stops
        .map(
          (stop) => Marker(
            width: 30,
            height: 30,
            point: LatLng(
              stop.latitude,
              stop.longitude,
            ),
            builder: (_) => MapStopMarker(stop: stop),
          ),
        )
        .toList();
  }
}
