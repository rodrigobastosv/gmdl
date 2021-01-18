import 'package:dio/dio.dart';

import '../entity/dto/dtos.dart';
import '../entity/model/models.dart';
import 'client/client.dart';
import 'filters/filters.dart';

class LoadingInfoRepository {
  LoadingInfoRepository(this._client);

  final Dio _client;

  Future<DriverInfoDto> getDriverInfo({
    String username,
  }) async {
    try {
      final response = await _client.post(
        '/$DRIVER/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: {
            FILTERS: driverFilters,
            FIRST_RESULT: 0,
            MAX_RESULTS: 51,
          },
        },
        data: {
          CRITERIA_CHAIN: [
            {
              AND: [
                {ATTR: 'login', EQUAL: username}
              ]
            },
          ],
        },
      );
      final driverInfoList = handleResponse(response) as List;
      if (driverInfoList.isNotEmpty) {
        return DriverInfoDto.fromJson(driverInfoList[0]);
      }
      return null;
    } on Exception {
      rethrow;
    }
  }

  Future<GlobalConfigurationsDto> getGlobalConfigurations() async {
    try {
      final response = await _client.post(
        '/$GLOBAL_CONFIGURATION/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: {
            FILTERS: globalConfigurationFilters,
          },
        },
      );
      final globalConfigs = handleResponse(response) as List;
      return GlobalConfigurationsDto.fromJson(globalConfigs[0]);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserConfigurations() async {
    try {
      final response = await _client.get(
        '/$CONFIGURATION/loggedUser',
      );
      return handleResponse(response);
    } on Exception {
      rethrow;
    }
  }

  Future<List<CancelCodeModel>> fetchCancelCodes() async {
    try {
      final response = await _client.post('/$CANCEL_CODE/$FILTER', data: {
        'enabled': true,
      });
      final responseData = handleResponse(response) as List;
      return List.generate(responseData.length,
          (i) => CancelCodeModel.fromJson(responseData[i]));
    } on Exception {
      rethrow;
    }
  }

  Future<List<UndeliverableCodeModel>> fetchUndeliverableCodes() async {
    try {
      final response =
          await _client.post('/$UNDELIVERABLE_CODE/$FILTER', data: {
        'enabled': true,
      });
      final responseData = handleResponse(response) as List;
      return List.generate(responseData.length,
          (i) => UndeliverableCodeModel.fromJson(responseData[i]));
    } on Exception {
      rethrow;
    }
  }
}
