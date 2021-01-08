import 'package:dio/dio.dart';

import 'client/client.dart';
import 'filters/filters.dart';

class EquipmentRepository {
  EquipmentRepository(this._client);

  final Dio _client;

  Future<bool> getEquipment(String equipmentKey) async {
    try {
      final response = await _client.post(
        '/$EQUIPMENT/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: {
            FILTERS: equipmentFilters,
            MAX_RESULTS: 51,
          },
        },
        data: {
          CRITERIA_CHAIN: [
            {
              AND: [
                {
                  ATTR: 'key',
                  EQUAL: equipmentKey,
                  MATCH_MODE: MatchMode.EXACT.value
                },
                {ATTR: 'enabled', EQUAL: true}
              ]
            }
          ],
          SORT: [
            {ATTR: 'key', TYPE: SortMode.ASC.value},
          ],
        },
      );
      return response.isOk;
    } on Exception {
      rethrow;
    }
  }
}
