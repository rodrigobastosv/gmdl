import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:polyline/polyline.dart' as p;

import '../../page/map/widget/map_stop_marker.dart';
import '../cubit/map/map_cubit.dart';
import '../entity/model/models.dart';
import 'utils.dart';

final tileOptions = TileLayerOptions(
  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  subdomains: ['a', 'b', 'c'],
);

// ignore: non_constant_identifier_names
final DEFAULT_LAT_LNG_IF_NONE_GIVEN = Position(
  latitude: 0.0,
  longitude: 0.0,
);
// ignore: non_constant_identifier_names
final DEFAULT_LATITUDE = DEFAULT_LAT_LNG_IF_NONE_GIVEN.latitude;
// ignore: non_constant_identifier_names
final DEFAULT_LONGITUDE = DEFAULT_LAT_LNG_IF_NONE_GIVEN.longitude;
const DEFAULT_MARKER_SIZE = 30.0;
const DEFAULT_MAP_ZOOM = 13.0;
const DEFAULT_POLYLINE_WIDTH = 2.0;
const PLANNED_PATH_COLOR = Color(0xFF800080);

List<LatLng> decodeEncodedPath(String encoded) {
  final polyline = p.Polyline.Decode(
    encodedString: encoded,
    precision: 6,
  );
  return polyline.decodedCoords
      .map(
        (coords) => LatLng(
          coords[0],
          coords[1],
        ),
      )
      .toList();
}

Marker getMarkerOnPosition(Position position) {
  return Marker(
    width: DEFAULT_MARKER_SIZE,
    height: DEFAULT_MARKER_SIZE,
    point: LatLng(
      position?.latitude ?? DEFAULT_LATITUDE,
      position?.longitude ?? DEFAULT_LONGITUDE,
    ),
    builder: (_) => SvgPicture.asset(
      'assets/icons/map-current-position.svg',
    ),
  );
}

List<Marker> getStopMarkers(List<StopModel> stops) {
  return stops
      .map(
        (stop) => Marker(
          width: DEFAULT_MARKER_SIZE,
          height: DEFAULT_MARKER_SIZE,
          point: LatLng(
            stop.latitude,
            stop.longitude,
          ),
          builder: (_) => MapStopMarker(
            stop: stop,
            isInProgress: false,
            isNextSuggestion: false,
          ),
        ),
      )
      .toList();
}

List<Marker> getMapStopMarkers(MapCubit mapCubit) {
  final route = mapCubit.routeCubit.route;
  final stops = route.stops;
  return stops
      .map(
        (stop) => Marker(
          width: DEFAULT_MARKER_SIZE,
          height: DEFAULT_MARKER_SIZE,
          point: LatLng(
            stop.latitude,
            stop.longitude,
          ),
          builder: (_) => GestureDetector(
            onTap: () => mapCubit.showStopOnMap(stop),
            child: MapStopMarker(
              stop: stop,
              isInProgress: stop.isInProgress,
              isNextSuggestion: isStopNextSuggestion(route, stop),
            ),
          ),
        ),
      )
      .toList();
}
