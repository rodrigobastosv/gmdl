import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:polyline/polyline.dart' as p;

final tileOptions = TileLayerOptions(
  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  subdomains: ['a', 'b', 'c'],
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
