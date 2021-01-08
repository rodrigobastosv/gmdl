import 'package:dio/dio.dart';

import '../entity/dto/route_view_info_dto.dart';
import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import 'client/client.dart';
import 'filters/filters.dart';
import 'filters/route_view_filters.dart';

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
            {ATTR: 'route.date', TYPE: SortMode.DESC.value},
            {ATTR: 'route.key', TYPE: SortMode.ASC.value}
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
      final routesList = handleResponse(response) as List;
      if (routesList.isEmpty) {
        throw ResourceNotFoundException(resource: 'ROUTE_VIEW');
      }
      return RouteViewInfoDTO.fromJson(routesList[0]);
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
      final routeData = handleResponse(response);
      if (routeData != null) {
        return RouteModel.fromJson(response.data['route']);
      } else {
        throw RouteNotFoundException(routeId);
      }
    } on Exception {
      rethrow;
    }
  }

  Future<bool> startRoute(int routeId) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$START',
        data: {
          'actualStart': DateTime.now().toUtc().toIso8601String(),
        },
      );
      return response.isOk;
    } on Exception {
      rethrow;
    }
  }
}
