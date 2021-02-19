import 'package:dio/dio.dart';

import '../entity/enum/enums.dart';
import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import 'client/client.dart';
import 'client/gm_client.dart';

class HosRepository {
  HosRepository(this._client);

  final GMClient _client;

  Future<void> startLunch({
    int driverId,
    String eventTime,
  }) async {
    try {
      await _client.post(
        '/$HOS/$START_LUNCH/$driverId',
        data: {
          'eventTime': eventTime,
          'eventType': hosEventTypeToJson(HosEventType.LUNCH_START),
        },
      );
    } on DioError catch (e) {
      throw HosEventException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw HosEventException(e.errorMessage);
    }
  }

  Future<void> endLunch({
    int driverId,
    String eventTime,
  }) async {
    try {
      await _client.post(
        '/$HOS/$END_LUNCH/$driverId',
        data: {
          'eventTime': eventTime,
          'eventType': hosEventTypeToJson(HosEventType.LUNCH_END),
        },
      );
    } on DioError catch (e) {
      throw HosEventException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw HosEventException(e.errorMessage);
    }
  }

  Future<Map<String, dynamic>> fetchHosInfo({
    int driverId,
  }) async {
    try {
      final response = await _client.get(
        '/$HOS/$STATUS/$BY_DRIVER/$driverId',
      );
      final responseData = handleResponse(response);
      final eventsList = responseData['events'] as List;
      final events = List.generate(
          eventsList.length, (i) => HosEventModel.fromJson(eventsList[i]));
      return {
        'hosType': HosTypeModel.fromJson(responseData['hoursOfServiceType']),
        'hosEvents': events,
      };
    } on DioError catch (e) {
      throw HosEventException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw HosEventException(e.errorMessage);
    }
  }
}
