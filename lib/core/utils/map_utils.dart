import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:polyline/polyline.dart' as p;

import '../../page/map/widget/map_stop_marker.dart';
import '../entity/model/models.dart';

final tileOptions = TileLayerOptions(
  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  subdomains: ['a', 'b', 'c'],
);

// ignore: non_constant_identifier_names
final DEFAULT_LAT_LNG_IF_NONE_GIVEN = Position(
  latitude: 0.0,
  longitude: 0.0,
);
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
    width: 30,
    height: 30,
    point: LatLng(
      position?.latitude ?? 0.0,
      position?.longitude ?? 0.0,
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
          width: 30,
          height: 30,
          point: LatLng(
            stop.latitude,
            stop.longitude,
          ),
          builder: (_) => MapStopMarker(
            stop: stop,
            isNextSuggestion: false,
          ),
        ),
      )
      .toList();
}
