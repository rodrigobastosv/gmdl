import 'dart:convert';

import 'package:dio/dio.dart';

import 'client/endpoints.dart';

class LoadingInfoRepository {
  LoadingInfoRepository(this._client);

  final Dio _client;

  Future<Map<String, dynamic>> getBasicDriverInfo({
    String username,
  }) async {
    try {
      final response = await _client.post(
        '/$DRIVER/restrictions',
        data: {
          'criteriaChain': [
            {
              'and': [
                {
                  'attr': 'login',
                  'eq': 'rodriver',
                }
              ]
            },
          ],
        },
        queryParameters: {
          'criteria': jsonEncode({
            'filters': jsonEncode(
              [
                'id',
                'login',
                'name',
                'key',
                'organization.id',
                'organization.key',
                'driverType',
                'smartTrack',
                'unitSystem',
                'udfs.key',
                'udfs.id',
                'udfs.value',
                'groups.id',
              ],
            ),
            'firstResult': 0,
            'maxResults': 51
          }),
        },
      );
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        final responseData = response.data[0] as Map<String, dynamic>;
        return responseData;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGlobalConfigurations() async {
    try {
      final response = await _client.post(
        '/$GLOBAL_CONFIGURATION/restrictions',
        queryParameters: {
          'criteria': jsonEncode({
            'filters': jsonEncode(
              [
                [
                  'size1AliasConfig.id',
                  'size1AliasConfig.key',
                  'size2AliasConfig.id',
                  'size2AliasConfig.key',
                  'size3AliasConfig.id',
                  'size3AliasConfig.key',
                  'authConfigId',
                  'allowChatBetweenDrivers'
                ]
              ],
            ),
          }),
        },
      );
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        final responseData = response.data[0] as Map<String, dynamic>;
        return responseData;
      }
    } on Exception {
      rethrow;
    }
  }
}
