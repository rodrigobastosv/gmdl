import '../fixtures/basic_route.dart';
import '../main_test.dart';
import 'cancel_code_data.dart';
import 'equipment_data.dart';
import 'order_class_data.dart';
import 'organization_data.dart';
import 'reason_code_data.dart';
import 'route_data.dart';
import 'size_alias_data.dart';
import 'sku_data.dart';

import 'package:gm_driver_lite/core/extension/extensions.dart';

import 'undeliverable_code_data.dart';

final now = DateTime.now().toUtcAsString;

Future<void> loadFixtureData() async {
  final route = basicRoute['route'] ?? [];
  final sizeAliases = basicRoute['sizeAliases'] ?? [];
  final skus = basicRoute['skus'] ?? [];
  final skuSizeConversions = basicRoute['skuSizeConversion'] ?? [];
  final cancelCodes = basicRoute['cancelCodes'] ?? [];
  final reasonCodes = basicRoute['reasonCodes'] ?? [];
  final undeliverableCodes = basicRoute['undeliverableCodes'] ?? [];
  final orderClasses = basicRoute['orderClasses'] ?? [];
  final skuTypes = basicRoute['skuTypes'] ?? [];
  final hosType = basicRoute['hosType'] ?? {};
  final paymentMethodAlloweds = basicRoute['paymentMethodAlloweds'] ?? [];
  final configuration = basicRoute['configuration'] ?? {};
  final skuOrganizationPriceLists =
      basicRoute['skuOrganizationPriceLists'] ?? [];
  final allowedSkuTypes = basicRoute['allowedSkuTypes'] ?? [];
  final locations = basicRoute['locations'] ?? [];
  final stopTypes = basicRoute['stopTypes'] ?? [];
  final equipments = basicRoute['equipments'] ?? [];
  final equipmentTypes = basicRoute['equipmentTypes'] ?? [];
  final drivers = basicRoute['drivers'] ?? [];
  final otherRoutes = basicRoute['otherRoutes'] ?? [];
  final taskTypes = basicRoute['taskTypes'] ?? [];

  createOrganization(organization: organization).then((org) async {
    await for (var equipmentType in equipmentTypes) {
      await createEquipmentType(equipmentType: equipmentType);
    }
    await for (var sizeAlias in sizeAliases) {
      await createSizeAlias(sizeAlias: sizeAlias);
    }
    await for (var skuType in skuTypes) {
      await createSkuType(skuType: skuType);
    }
    await for (var sku in skus) {
      await createSku(
        organization: org,
        sku: sku,
      );
    }

    await importRoute(
      route: route,
      organization: org,
    );

    await for (var orderClass in orderClasses) {
      await createOrderClass(
        orderClass: orderClass,
        organization: org,
      );
    }

    await for (var cancelCode in cancelCodes) {
      await createCancelCode(
        cancelCode: cancelCode,
        organization: org,
      );
    }

    await for (var reasonCode in reasonCodes) {
      await createReasonCode(
        reasonCode: reasonCode,
        organization: org,
      );
    }

    await for (var undeliverableCode in undeliverableCodes) {
      await createUndeliverableCode(
        undeliverableCode: undeliverableCode,
        organization: org,
      );
    }

    /*setAutoHOSConfiguration({ org: this.org,
          skuSizeConversions.forEach((skuSizeConversion) => {
            if (skuSizeConversion.sizeAlias.key === this.size1AliasConfig.key) {
              skuSizeConversion.sizeAlias.id = this.size1AliasConfig.id;
            } else if (skuSizeConversion.sizeAlias.key === this.size2AliasConfig.key) {
              skuSizeConversion.sizeAlias.id = this.size2AliasConfig.id;
            } else if (skuSizeConversion.sizeAlias.key === this.size3AliasConfig.key) {
              skuSizeConversion.sizeAlias.id = this.size3AliasConfig.id;
            }
            createSkuSizeConversion({ skuSizeConversion });
          });
          allowedSkuTypes.forEach((allowedSkuType) => {
            createAllowedSkuType({ allowedSkuType, organization: this.org });
          });
          locations.forEach((location, index) => {
            createLocation({ key: location.key, org: this.org, type: location.locationType }).as(`location${index + 1}`);
          });
          stopTypes.forEach((stopType, index) => {
            createStopType({ key: stopType.key, org: this.org, type: stopType.type }).as(`stopType${index + 1}`);
          });
          equipments.forEach((equipment, index) => {
            createEquipment({ equipment }).as(`equipment${index + 1}`);
          });
          drivers.forEach((driver, index) => {
            createDriver({ driver }).as(`driver${index + 1}`);
          });
          taskTypes.forEach((taskType, index) => {
            createTaskType({ ...taskType, organization: this.org }).as(`taskType${index + 1}`);
          });*/
  });
}

void addOrganizationToEntity(Map<String, dynamic> entity) {
  if (entity['organization']) {
    entity['organization'] = {...entity['organization'], organization};
  } else {
    entity['organization'] = organization;
  }
}

Map<String, dynamic> updateRouteOrganization({
  Map<String, dynamic> route,
  String organizationKey,
}) {
  final organization = {
    'key': organizationKey,
  };

  route['organization'] = {
    ...route['organization'],
    ...organization,
  };

  if (route['origin']) {
    addOrganizationToEntity(route['origin']);

    if (route['origin']['locationType']) {
      addOrganizationToEntity(route['origin']['locationType']);
    }
  }

  if (route['destination']) {
    addOrganizationToEntity(route['destination']);

    if (route['destination']['locationType']) {
      addOrganizationToEntity(route['destination']['locationType']);
    }
  } else {
    route['lastStopIsDestination'] = true;
  }

  if (route['driverAssignments'] != null) {
    for (var i = 0; i < route['driverAssignments'].length; i++) {
      addOrganizationToEntity(route['driverAssignments'][i]['driver']);
    }
  }

  if (route['equipmentAssignments'] != null) {
    for (var i = 0; i < route['equipmentAssignments'].length; i++) {
      addOrganizationToEntity(route['equipmentAssignments'][i]['equipment']);
      addOrganizationToEntity(
          route['equipmentAssignments'][i]['equipment']['equipmentType']);
    }
  }

  if (route['notLoadedSkus'] != null) {
    for (var i = 0; i < route['notLoadedSkus'].length; i++) {
      addOrganizationToEntity(route['notLoadedSkus'][i]['sku']);

      if (route['notLoadedSkus'][i].transport != null) {
        addOrganizationToEntity(route['notLoadedSkus'][i]['transport']);
        route['notLoadedSkus'][i]['transport']['date'] = now;
      }
    }
  }

  if (route['additionalMaterials'] != null) {
    for (var i = 0; i < route['additionalMaterials'].length; i++) {
      addOrganizationToEntity(route['additionalMaterials'][i]['sku']);

      if (route['additionalMaterials'][i]['transport'] != null) {
        addOrganizationToEntity(route['additionalMaterials'][i]['transport']);
        route['additionalMaterials'][i]['transport']['date'] = now;
      }
    }
  }

  if (route['stops'] != null) {
    for (var i = 0; i < route['stops'].length; i++) {
      if (route['stops'][i]['stopType'] != null) {
        addOrganizationToEntity(route['stops'][i]['stopType']);
      }

      if (route['stops'][i]['location'] != null) {
        addOrganizationToEntity(route['stops'][i]['location']);

        if (route['stops'][i]['location']['locationType'] != null) {
          addOrganizationToEntity(
              route['stops'][i]['location']['locationType']);
        }
      }

      if (route['stops'][i]['transport'] != null) {
        route['stops'][i]['transport']['date'] = now;
      }

      if (route['stops'][i]['orders'] != null) {
        for (var j = 0; j < route['stops'][i]['orders'].length; j++) {
          if (route['stops'][i]['orders'][j]['orderClass']) {
            addOrganizationToEntity(
                route['stops'][i]['orders'][j]['orderClass']);
          }

          if (route['stops'][i]['orders'][j] != null) {
            for (var w = 0;
                w < route['stops'][i]['orders'][j]['lineItems'].length;
                w++) {
              addOrganizationToEntity(
                  route['stops'][i]['orders'][j]['lineItems'][w]['sku']);

              if (route['stops'][i]['orders'][j]['lineItems'][w]['sku']
                  ['secondaryCompound']) {
                addOrganizationToEntity(route['stops'][i]['orders'][j]
                    ['lineItems'][w]['sku']['secondaryCompound']);
              }

              if (route['stops'][i]['orders'][j]['lineItems'][w]['sku']
                  ['tertiaryCompound']) {
                addOrganizationToEntity(route['stops'][i]['orders'][j]
                    ['lineItems'][w]['sku']['tertiaryCompound']);
              }
            }
          }
        }
      }
    }
  }

  return route;
}

Map<String, dynamic> addTimesToRoute(Map<String, dynamic> route) {
  final now = DateTime.now().toUtcAsString;
  final routeWithDateAndTimes = {
    ...route,
    'date': route['date'] ?? now,
    'plannedArrival': route['plannedArrival'] ?? now,
    'plannedDeparture': route['plannedDeparture'] ?? now,
    'plannedComplete': route['plannedComplete'] ?? now,
    'plannedStart': route['plannedStart'] ?? now,
  };

  if (routeWithDateAndTimes['stops'] != null) {
    for (var i = 0; i < routeWithDateAndTimes['stops'].length; i++) {
      routeWithDateAndTimes['stops'][i] = {
        ...routeWithDateAndTimes['stops'][i],
        'plannedArrival':
            routeWithDateAndTimes['stops'][i]['plannedArrival'] ?? now,
        'plannedDeparture':
            routeWithDateAndTimes['stops'][i]['plannedDeparture'] ?? now
      };
    }
  }

  return routeWithDateAndTimes;
}
