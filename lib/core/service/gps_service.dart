import 'dart:async';

import 'package:geolocator/geolocator.dart';

const PING_INTERVAL = Duration(seconds: 30);
const DESIRED_ACCURACY = LocationAccuracy.bestForNavigation;

class GpsService {
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: DESIRED_ACCURACY,
    );
  }

  Future<Position> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      desiredAccuracy: DESIRED_ACCURACY,
      intervalDuration: PING_INTERVAL,
    );
  }
}
