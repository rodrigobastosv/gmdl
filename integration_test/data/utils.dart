import '../fixtures/basic_route.dart';
import 'cancel_code_data.dart';
import 'driver_data.dart';
import 'equipment_data.dart';
import 'location_data.dart';
import 'order_class_data.dart';
import 'organization_data.dart';
import 'reason_code_data.dart';
import 'route_data.dart';
import 'size_alias_data.dart';
import 'sku_data.dart';

import 'package:gm_driver_lite/core/extension/extensions.dart';

import 'stop_data.dart';
import 'undeliverable_code_data.dart';

final now = DateTime.now().toUtcAsString;

Future<int> loadFixtureData() async {
  final route = basicRoute['route'] as Map<String, dynamic>;
  final org = route['organization'];
  final sizeAliases = basicRoute['sizeAliases'] ?? [];
  final skus = basicRoute['skus'] ?? [];
  //final skuSizeConversions = basicRoute['skuSizeConversion'] ?? [];
  final cancelCodes = basicRoute['cancelCodes'] ?? [];
  final reasonCodes = basicRoute['reasonCodes'] ?? [];
  final undeliverableCodes = basicRoute['undeliverableCodes'] ?? [];
  final orderClasses = basicRoute['orderClasses'] ?? [];
  final skuTypes = basicRoute['skuTypes'] ?? [];
  //final hosType = basicRoute['hosType'] ?? {};
  //final paymentMethodAlloweds = basicRoute['paymentMethodAlloweds'] ?? [];
  //final configuration = basicRoute['configuration'] ?? {};
  //final skuOrganizationPriceLists =
  //  basicRoute['skuOrganizationPriceLists'] ?? [];
  //final allowedSkuTypes = basicRoute['allowedSkuTypes'] ?? [];
  final locations = basicRoute['locations'] ?? [];
  final stopTypes = basicRoute['stopTypes'] ?? [];
  final equipments = basicRoute['equipments'] ?? [];
  final equipmentTypes = basicRoute['equipmentTypes'] ?? [];
  final drivers = basicRoute['drivers'] ?? [];
  //final otherRoutes = basicRoute['otherRoutes'] ?? [];
  //final taskTypes = basicRoute['taskTypes'] ?? [];

  final organization = await createOrganization(organization: org);

  for (var equipmentType in equipmentTypes) {
    await createEquipmentType(
      equipmentType: equipmentType,
      organization: organization,
    );
  }

  for (var sizeAlias in sizeAliases) {
    await createSizeAlias(
      sizeAlias: sizeAlias,
    );
  }

  for (var skuType in skuTypes) {
    await createSkuType(
      skuType: skuType,
      organization: organization,
    );
  }

  for (var sku in skus) {
    await createSku(
      sku: sku,
      organization: organization,
    );
  }

  await importRoute(
    route: route,
    organization: organization,
  );

  for (var orderClass in orderClasses) {
    await createOrderClass(
      orderClass: orderClass,
      organization: organization,
    );
  }

  for (var cancelCode in cancelCodes) {
    await createCancelCode(
      cancelCode: cancelCode,
      organization: organization,
    );
  }

  for (var reasonCode in reasonCodes) {
    await createReasonCode(
      reasonCode: reasonCode,
      organization: organization,
    );
  }

  for (var undeliverableCode in undeliverableCodes) {
    await createUndeliverableCode(
      undeliverableCode: undeliverableCode,
      organization: organization,
    );
  }

  for (var location in locations) {
    await createLocation(
      location: location,
      organization: organization,
    );
  }

  for (var stopType in stopTypes) {
    await createStopType(
      stopType: stopType,
      organization: organization,
    );
  }

  for (var equipment in equipments) {
    await createEquipment(
      equipment: equipment,
      organization: organization,
    );
  }

  for (var driver in drivers) {
    await createDriver(
      driver: driver,
      organization: organization,
    );
  }

  return organization['id'];
}

void addOrganizationToEntity(
  Map<String, dynamic> entity,
  Map<dynamic, dynamic> organization,
) {
  if (entity['organization'] != null) {
    entity['organization'] = {
      ...entity['organization'],
      organization,
    };
  } else {
    entity['organization'] = organization;
  }
}

Map<String, dynamic> updateRouteOrganization({
  Map<String, dynamic> route,
  String organizationKey,
}) {
  final organization = {
    ...route['organization'],
    'key': organizationKey,
  };

  route['organization'] = {
    ...organization,
  };

  if (route['origin'] != null) {
    addOrganizationToEntity(route['origin'], organization);

    if (route['origin']['locationType'] != null) {
      addOrganizationToEntity(route['origin']['locationType'], organization);
    }
  }

  if (route['destination'] != null) {
    addOrganizationToEntity(route['destination'], organization);

    if (route['destination']['locationType'] != null) {
      addOrganizationToEntity(
          route['destination']['locationType'], organization);
    }
  } else {
    route['lastStopIsDestination'] = true;
  }

  if (route['driverAssignments'] != null) {
    for (var i = 0; i < route['driverAssignments'].length; i++) {
      addOrganizationToEntity(
          route['driverAssignments'][i]['driver'], organization);
    }
  }

  if (route['equipmentAssignments'] != null) {
    for (var i = 0; i < route['equipmentAssignments'].length; i++) {
      addOrganizationToEntity(
          route['equipmentAssignments'][i]['equipment'], organization);
      addOrganizationToEntity(
          route['equipmentAssignments'][i]['equipment']['equipmentType'],
          organization);
    }
  }

  if (route['notLoadedSkus'] != null) {
    for (var i = 0; i < route['notLoadedSkus'].length; i++) {
      addOrganizationToEntity(route['notLoadedSkus'][i]['sku'], organization);

      if (route['notLoadedSkus'][i].transport != null) {
        addOrganizationToEntity(
            route['notLoadedSkus'][i]['transport'], organization);
        route['notLoadedSkus'][i]['transport']['date'] = now;
      }
    }
  }

  if (route['additionalMaterials'] != null) {
    for (var i = 0; i < route['additionalMaterials'].length; i++) {
      addOrganizationToEntity(
          route['additionalMaterials'][i]['sku'], organization);

      if (route['additionalMaterials'][i]['transport'] != null) {
        addOrganizationToEntity(
            route['additionalMaterials'][i]['transport'], organization);
        route['additionalMaterials'][i]['transport']['date'] = now;
      }
    }
  }

  if (route['stops'] != null) {
    for (var i = 0; i < route['stops'].length; i++) {
      if (route['stops'][i]['stopType'] != null) {
        addOrganizationToEntity(route['stops'][i]['stopType'], organization);
      }

      if (route['stops'][i]['location'] != null) {
        addOrganizationToEntity(route['stops'][i]['location'], organization);

        if (route['stops'][i]['location']['locationType'] != null) {
          addOrganizationToEntity(
              route['stops'][i]['location']['locationType'], organization);
        }
      }

      if (route['stops'][i]['transport'] != null) {
        route['stops'][i]['transport']['date'] = now;
      }

      if (route['stops'][i]['orders'] != null) {
        for (var j = 0; j < route['stops'][i]['orders'].length; j++) {
          if (route['stops'][i]['orders'][j]['orderClass']) {
            addOrganizationToEntity(
                route['stops'][i]['orders'][j]['orderClass'], organization);
          }

          if (route['stops'][i]['orders'][j] != null) {
            for (var w = 0;
                w < route['stops'][i]['orders'][j]['lineItems'].length;
                w++) {
              addOrganizationToEntity(
                  route['stops'][i]['orders'][j]['lineItems'][w]['sku'],
                  organization);

              if (route['stops'][i]['orders'][j]['lineItems'][w]['sku']
                  ['secondaryCompound']) {
                addOrganizationToEntity(
                    route['stops'][i]['orders'][j]['lineItems'][w]['sku']
                        ['secondaryCompound'],
                    organization);
              }

              if (route['stops'][i]['orders'][j]['lineItems'][w]['sku']
                  ['tertiaryCompound']) {
                addOrganizationToEntity(
                    route['stops'][i]['orders'][j]['lineItems'][w]['sku']
                        ['tertiaryCompound'],
                    organization);
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
  return routeWithDateAndTimes;
}
