import 'package:dio/dio.dart';

import '../entity/dto/route_view_info_dto.dart';
import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import '../extension/extensions.dart';
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
          'actualStart': DateTime.now().toUtcAsString,
        },
      );
      return response.isOk;
    } on Exception {
      throw StartRouteException();
    }
  }

  Future<bool> departOrigin(int routeId) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$DEPART_ORIGIN',
        data: {
          'actualDeparture': DateTime.now().toUtcAsString,
        },
      );
      return response.isOk;
    } on Exception {
      throw DepartOriginException();
    }
  }

  Future<bool> arriveStop(int routeId, StopModel stop) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$STOP/${stop.key}/$ARRIVE',
        data: {
          'actualArrival': DateTime.now().toUtcAsString,
        },
      );
      return response.isOk;
    } on Exception {
      throw ArriveStopException();
    }
  }

  Future<bool> arriveWarehouse(int routeId) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$ARRIVE_DESTINATION',
        data: {
          'actualArrival': DateTime.now().toUtcAsString,
        },
      );
      return response.isOk;
    } on Exception {
      throw ArriveStopException();
    }
  }

  Future<bool> completeRoute(int routeId) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$routeId/$COMPLETE',
        data: {
          'actualComplete': DateTime.now().toUtcAsString,
          'amountReceived': 0,
        },
      );
      return response.isOk;
    } on Exception {
      throw ArriveStopException();
    }
  }
}
