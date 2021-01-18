import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import '../utils/utils.dart';
import 'client/client.dart';
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
    } on DioError catch (e) {
      throw ArriveStopException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw ArriveStopException(e.errorMessage);
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
    } on DioError catch (e) {
      throw DepartStopException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw DepartStopException(e.errorMessage);
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
    } on DioError catch (e) {
      throw CloneStopException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw CloneStopException(e.errorMessage);
    }
  }

  Future<bool> cancelStop({
    @required int routeId,
    @required int cancelCode,
    @required String stopKey,
    @required String actualCancel,
  }) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$STOP/$CANCEL',
        data: {
          'actualCancel': actualCancel,
          'cancelCode': {
            'id': cancelCode
          },
          'stops': [
            {'key': stopKey}
          ]
        },
      );
      return response.isOk;
    } on DioError catch (e) {
      throw CancelStopException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw CancelStopException(e.errorMessage);
    }
  }

  Future<bool> undeliverStop({
    @required int routeId,
    @required int undeliverableCode,
    @required String actualDeparture,
    @required String stopKey,
  }) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$STOP/$stopKey/$RETURN',
        data: {
          'actualDeparture': actualDeparture,
          'undeliverableCode': {
            'id': undeliverableCode
          },
        },
      );
      return response.isOk;
    } on DioError catch (e) {
      throw CancelStopException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw CancelStopException(e.errorMessage);
    }
  }
}
