import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import 'client/client.dart';
import '../utils/utils.dart';
import 'filters/filters.dart';

class StopRepository {
  StopRepository(this._client);

  final Dio _client;

  Future<bool> arriveStop({
    int routeId,
    StopModel stop,
    String actualArrival,
  }) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$STOP/${stop.key}/$ARRIVE',
        data: {
          'actualArrival': actualArrival,
        },
      );
      return response.isOk;
    } on Exception {
      throw ArriveStopException();
    }
  }

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

  Future<StopModel> cloneStop({
    @required int routeId,
    @required StopModel stop,
  }) async {
    try {
      final response = await _client.post(
        '/$STOP/${stop.key}/$ROUTE/$routeId/$CLONE',
        queryParameters: {
          CRITERIA: {
            FILTERS: cloneStopFilters,
          },
        },
        data: {
          'key': generateCloneStopKey(),
        },
      );
      final responseData = handleResponse(response);
      return StopModel.fromJson(responseData);
    } on Exception {
      throw CloneStopException();
    }
  }
}
