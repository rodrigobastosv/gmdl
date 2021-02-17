import 'package:dio/dio.dart';

import '../entity/dto/route_view_info_dto.dart';
import '../entity/model/models.dart';
import '../exception/exceptions.dart';
import '../exception/none_route_found_exception.dart';
import '../extension/extensions.dart';
import 'client/client.dart';
import 'client/gm_client.dart';
import 'filters/filters.dart';
import 'filters/route_view_filters.dart';

class RouteRepository {
  RouteRepository(this._client);

  final GMClient _client;

  Future<RouteViewInfoDTO> fetchRouteView(String username) async {
    try {
      final response = await _client.post(
        '/$ROUTE_VIEW/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: getCriteria({
            FILTERS: routeViewFilters,
            MAX_RESULTS: 51,
          }),
        },
        data: {
          SORT: [
            {ATTR: 'route.date', TYPE: SortMode.DESC.value},
            {ATTR: 'route.key', TYPE: SortMode.ASC.value}
          ],
          CRITERIA_CHAIN: [
            {
              AND: [
                {ATTR: 'route.status', NOT_EQUAL: 'COMPLETED'},
                {ATTR: 'route.driverAssignments.driver.login', EQUAL: username}
              ]
            }
          ]
        },
      );
      final routesList = handleResponse(response) as List;
      if (routesList.isEmpty) {
        throw NoneRouteFoundException();
      }
      return RouteViewInfoDTO.fromJson(routesList[0]);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchRoute(int routeId) async {
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
      return handleResponse(response);
    } on DioError catch (e) {
      throw FetchRouteException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw FetchRouteException(e.errorMessage);
    }
  }

  Future<String> fetchRoutePath(int routeId) async {
    try {
      final response = await _client.get('/$ROUTE/$routeId/$ENCODED_PATH');
      return response.data as String;
    } on DioError catch (e) {
      throw FetchRouteException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw FetchRouteException(e.errorMessage);
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
    } on DioError catch (e) {
      throw StartRouteException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw StartRouteException(e.errorMessage);
    }
  }

  Future<ProactiveRouteOptConfigModel> fetchProConfig(int routeId) async {
    try {
      final response = await _client.post(
        '/$ROUTE/$RESTRICTIONS',
        queryParameters: {
          CRITERIA: getCriteria({
            FILTERS: proConfigFilters,
          }),
        },
        data: {
          CRITERIA_CHAIN: [
            {
              AND: [
                {ATTR: 'id', EQUAL: routeId},
              ]
            }
          ]
        },
      );
      final responseDataList = handleResponse(response) as List;
      final responseData = responseDataList[0];
      final proactiveRouteOptConfigData =
          responseData['proactiveRouteOptConfig'];
      return proactiveRouteOptConfigData != null
          ? ProactiveRouteOptConfigModel.fromJson(proactiveRouteOptConfigData)
          : null;
    } on DioError catch (e) {
      throw StartRouteException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw StartRouteException(e.errorMessage);
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
    } on DioError catch (e) {
      throw DepartOriginException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw DepartOriginException(e.errorMessage);
    }
  }

  Future<void> arriveStop({
    int routeId,
    StopModel stop,
    String actualArrival,
  }) async {
    try {
      await _client.postQueued(
        '/$ROUTE/$routeId/$STOP/${stop.key}/$ARRIVE',
        data: {
          'actualArrival': actualArrival,
        },
      );
    } on DioError catch (e) {
      throw ArriveStopException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw ArriveStopException(e.errorMessage);
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
    } on DioError catch (e) {
      throw ArriveWarehouseException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw ArriveWarehouseException(e.errorMessage);
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
    } on DioError catch (e) {
      throw CompleteRouteException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw CompleteRouteException(e.errorMessage);
    }
  }

  Future<RouteModel> syncRouteByNotification(int routeId) async {
    try {
      final response = await _client.post(
        '/$APLICATION_LOAD_DRIVER',
        data: {
          'routeId': routeId,
          'routeFilters': routeByNotificationFilters,
          'stopFilters': stopFilters,
          'locationsFilters': locationFilters,
          'ordersFilters': ordersFilters,
          'lineItemsFilters': lineItemsFilters,
        },
      );
      final responseData = handleResponse(response);
      return RouteModel.fromJson(responseData['route']);
    } on DioError catch (e) {
      throw FetchRouteException(getErrorMessage(e));
    } on GMServerException catch (e) {
      throw FetchRouteException(e.errorMessage);
    }
  }
}
