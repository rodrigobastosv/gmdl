import 'package:dio/dio.dart';

import '../entity/dto/route_view_info_dto.dart';
import '../entity/model/models.dart';
import 'client/client.dart';
import 'filters/route_view_filters.dart';
import 'filters/filters.dart';

class RouteRepository {
  RouteRepository(this._client);

  final Dio _client;

  Future<RouteViewInfoDTO> fetchRouteView(String username) async {
    try {
      final response = await _client.post(
        '/$ROUTE_VIEW/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: {
            FILTERS: routeViewFilters,
            MAX_RESULTS: 51,
          },
        },
        data: {
          SORT: [
            {ATTR: 'route.date', TYPE: 'DESC'},
            {ATTR: 'route.key', TYPE: 'ASC'}
          ],
          CRITERIA_CHAIN: [
            {
              AND: [
                {ATTR: 'route.status', EQUAL: 'NOT_STARTED'},
                {ATTR: 'route.driverAssignments.driver.login', EQUAL: username}
              ]
            }
          ]
        },
      );
      if (response.statusCode != 200) {
        throw Exception();
      }
      final routesList = response.data as List;
      if (routesList.isNotEmpty) {
        return RouteViewInfoDTO.fromJson(routesList[0]);
      } else {
        return null;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<RouteModel> fetchRoute(int routeId) async {
    try {
      final response = await _client.post(
        '/$APLICATION_LOAD_DRIVER',
        data: {
          'routeId': routeId,
          'routeFilters': routeFilters,
          'stopFilters': stopFilters,
          'locationPendingPaymentFilters': locationPendingPaymentFilters,
          'consignedSkuFilters': consignedSkuFilters,
          'locationsFilters': locationFilters,
          'ordersFilters': ordersFilters,
          'lineItemsFilters': lineItemsFilters,
          'holderMaterialsFilters': holderMaterialsFilters,
        },
      );
      if (response.statusCode != 200) {
        throw Exception();
      }
      return RouteModel.fromJson(response.data['route']);
    } on Exception {
      rethrow;
    }
  }
}
