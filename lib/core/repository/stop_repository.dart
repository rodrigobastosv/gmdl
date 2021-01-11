import 'package:dio/dio.dart';

import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import 'client/client.dart';

class StopRepository {
  StopRepository(this._client);

  final Dio _client;

  Future<bool> departStop({
    int routeId,
    StopModel stop,
    String actualDeparture,
  }) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$STOP/${stop.key}/$DEPART',
        data: {
          'actualDeparture': actualDeparture,
        },
      );
      return response.isOk;
    } on Exception catch (e) {
      if (e is DioError) {
        return e.response.isPrecondictionFailed;
      }
      throw DepartStopException();
    }
  }
}
