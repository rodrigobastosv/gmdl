import 'package:dio/dio.dart';

import '../entity/model/models.dart';
import 'client/client.dart';
import 'filters/filters.dart';

class EntityRepository {
  EntityRepository(this._client);

  final Dio _client;

  Future<List<StopTypeModel>> fetchStopTypes() async {
    try {
      final response = await _client.post(
        '/$STOP_TYPE/$FILTER',
        queryParameters: {
          CRITERIA: {
            FILTERS: stopTypeFilters,
          },
        },
        data: {},
      );
      final responseData = handleResponse(response);
      return StopTypeModel.fromJsonList(responseData);
    } on Exception {
      rethrow;
    }
  }

  Future<List<OrderClassModel>> fetchOrderClasses() async {
    try {
      final response = await _client.post(
        '/$ORDER_CLASS',
      );
      final responseData = handleResponse(response);
      return OrderClassModel.fromJsonList(responseData);
    } on Exception {
      rethrow;
    }
  }
}
