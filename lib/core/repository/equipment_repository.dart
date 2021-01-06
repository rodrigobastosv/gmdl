import 'dart:convert';

import 'package:dio/dio.dart';

import 'client/endpoints.dart';

class EquipmentRepository {
  EquipmentRepository(this._client);

  final Dio _client;

  Future<bool> getEquipment(String equipmentKey) async {
    try {
      final response = await _client.post(
        '/$EQUIPMENT/restrictions',
        queryParameters: {
          'criteria': jsonEncode({
            'filters': jsonEncode(
              [
                'id',
                'key',
                'description',
                'organization.id',
                'organization.key',
                'organization.description',
                'gpsProvider.id',
                'gpsUnitId',
                'equipmentType.*'
              ],
            ),
            'maxResults': 51
          }),
        },
        data: {
          'criteriaChain': [
            {
              'and': [
                {'matchMode': 'EXACT', 'attr': 'key', 'eq': equipmentKey},
                {'attr': 'enabled', 'eq': true}
              ]
            }
          ],
          'sort': [
            {'attr': 'key', 'type': 'ASC'},
          ],
        },
      );
      return response.statusCode == 200;
    } on Exception {
      rethrow;
    }
  }
}
