import 'package:latlong/latlong.dart';
import 'package:polyline/polyline.dart';

List<LatLng> decodeEncodedPath(String encoded) {
  final polyline = Polyline.Decode(
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
