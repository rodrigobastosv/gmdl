import '../utils/gps_utils.dart';
import 'client/endpoints.dart';
import 'client/gm_client.dart';

class GpsRepository {
  GpsRepository(this._client);

  final GMClient _client;

  Future<void> sendStopArrivalGpsInfo({
    int routeId,
    String stopKey,
    double accuracyMeters,
    double latitude,
    double longitude,
  }) async {
    try {
      await _client.post(
        '/$ROUTE/$routeId/$STOP/$stopKey/$GEOLOCATION',
        data: {
          'arrivalAccuracyMeters': accuracyMeters,
          'arrivalLatitude': latitude,
          'arrivalLongitude': longitude,
          'arrivalMobileGpsProvider': DEFAULT_MOBILE_GPS_PROVIDER,
        },
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> sendStopDepartureGpsInfo({
    int routeId,
    String stopKey,
    double accuracyMeters,
    double latitude,
    double longitude,
  }) async {
    try {
      await _client.post(
        '/$ROUTE/$routeId/$STOP/$stopKey/$GEOLOCATION_DEPARTURE',
        data: {
          'departureAccuracyMeters': accuracyMeters,
          'departureLatitude': latitude,
          'departureLongitude': longitude,
          'departureMobileGpsProvider': DEFAULT_MOBILE_GPS_PROVIDER,
        },
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> sendStopCancelGpsInfo({
    int routeId,
    String stopKey,
    double accuracyMeters,
    double latitude,
    double longitude,
  }) async {
    try {
      await _client.post(
        '/$ROUTE/$routeId/$STOP/$stopKey/$GEOLOCATION_CANCEL',
        data: {
          'cancelAccuracyMeters': accuracyMeters,
          'cancelLatitude': latitude,
          'cancelLongitude': longitude,
          'cancelMobileGPSProvider': DEFAULT_MOBILE_GPS_PROVIDER,
        },
      );
    } on Exception {
      rethrow;
    }
  }
}
