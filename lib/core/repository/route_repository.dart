import 'dart:convert';

import 'package:dio/dio.dart';

import '../entity/dto/route_view_info_dto.dart';
import 'client/endpoints.dart';

class RouteRepository {
  RouteRepository(this._client);

  final Dio _client;

  Future<RouteViewInfoDTO> fetchRouteView(String username) async {
    try {
      final response = await _client.post(
        '/$ROUTE_VIEW/restrictions',
        queryParameters: {
          'criteria': jsonEncode({
            'filters': jsonEncode(
              [
                'primaryEquipment.gpsProvider.id',
                'primaryEquipment.gpsUnitId',
                'primaryEquipment.id',
                'primaryEquipment.key',
                'primaryEquipment.description',
                'primaryEquipment.equipmentType.key',
                'primaryEquipment.equipmentType.description',
                'primaryEquipment.equipmentType.weight',
                'primaryEquipment.equipmentType.height',
                'primaryEquipment.equipmentType.size1',
                'primaryEquipment.equipmentType.size2',
                'primaryEquipment.equipmentType.size3',
                'route.date',
                'route.description',
                'route.origin.description',
                'route.driverAssignments.driver.id',
                'route.driverAssignments.driver.login',
                'route.driverAssignments.id',
                'route.helperAssignments.helper.id',
                'route.helperAssignments.helper.login',
                'route.helperAssignments.id',
                'route.id',
                'route.key',
                'route.organization.description',
                'route.organization.id',
                'route.organization.key',
                'route.organization.parentOrganization.id',
                'route.plannedStart',
                'route.status',
                'route.totalStops'
              ],
            ),
            'maxResults': 51
          }),
        },
        data: {
          'sort': [
            {'attr': 'route.date', 'type': 'DESC'},
            {'attr': 'route.key', 'type': 'ASC'}
          ],
          'criteriaChain': [
            {
              'and': [
                {'eq': 'NOT_STARTED', 'attr': 'route.status'},
                {
                  'attr': 'route.driverAssignments.driver.login',
                  'eq': username,
                }
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
}
