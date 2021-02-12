import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gm_driver_lite/core/entity/model/models.dart';

import 'package:gm_driver_lite/core/utils/utils.dart';

import 'package:latlong/latlong.dart';

void main() {
  group('Map Utils', () {
    test(
      '''WHEN decodeEncodedPath is called
         SHOULD return a list of LatLng
      ''',
      () {
        final encodedPath = 'egi~F~rbvO';
        final decodedPath = decodeEncodedPath(encodedPath);
        final latLng = LatLng(4.183171, -8.767296);
        expect(decodedPath.first.latitude, latLng.latitude);
        expect(decodedPath.first.longitude, latLng.longitude);
      },
    );

    test(
      '''WHEN getMarkerOnPosition is called
         SHOULD return a Marker
      ''',
      () {
        final marker = getMarkerOnPosition(
          Position(
            latitude: 0,
            longitude: 0,
          ),
        );
        expect(marker is Marker, true);
      },
    );

    test(
      '''WHEN getStopMarkers is called
         SHOULD return a list of Markers
      ''',
      () {
        final stopMarkers = getStopMarkers(
          [
            StopModel(
              latitude: 0,
              longitude: 0,
            ),
            StopModel(
              latitude: 1,
              longitude: 1,
            ),
          ],
        );
        expect(stopMarkers[0] is Marker, true);
        expect(stopMarkers[1] is Marker, true);
      },
    );
  });
}
