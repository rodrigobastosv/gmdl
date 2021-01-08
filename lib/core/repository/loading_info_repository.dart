import 'package:dio/dio.dart';

import 'client/client.dart';
import 'filters/filters.dart';

class LoadingInfoRepository {
  LoadingInfoRepository(this._client);

  final Dio _client;

  Future<Map<String, dynamic>> getBasicDriverInfo({
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
        return driverInfoList[0] as Map<String, dynamic>;
      }
      return {};
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGlobalConfigurations() async {
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
      return globalConfigs[0] as Map<String, dynamic>;
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
}
