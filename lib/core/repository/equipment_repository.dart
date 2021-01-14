import 'package:dio/dio.dart';
import '../exception/equipment_not_found_exception.dart';
import '../exception/exceptions.dart';

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
      final responseData = handleResponse(response) as List;
      if (responseData.isEmpty) {
          throw EquipmentNotFoundException();
        } else {
          return true;
        }
    } on Exception {
      rethrow;
    }
  }
}
