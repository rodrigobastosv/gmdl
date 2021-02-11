import 'package:dio/dio.dart';

import '../entity/enum/enums.dart';
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
}
