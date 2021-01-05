import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart';

import 'api.dart';

class DriverInfoRepository {
  DriverInfoRepository(this._client);

  final Dio _client;

  Future<Map<String, dynamic>> getDriverInfo({
    String username,
  }) async {
    print('a');
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
      print('b');
      if (response.statusCode != 200) {
        print('c');
        throw Exception(response.statusMessage);
      } else {
        final responseData = response.data[0] as Map<String, dynamic>;
        return responseData;
      }
    } on Exception catch (e) {
      print(e);
      print(e.toString());
      rethrow;
    }
  }
}
