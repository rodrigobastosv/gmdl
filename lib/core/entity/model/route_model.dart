import 'base_unit_model.dart';
import 'location_model.dart';
import 'organization_model.dart';
import 'stop_model.dart';

class RouteModel {
  int id;
  OrganizationModel organization;
  String key;
  String date;
  String description;
  LocationModel origin;
  double origLatitude;
  double origLongitude;
  LocationModel destination;
  double destLatitude;
  double destLongitude;
  bool lastStopIsDestination;
  List<StopModel> stops;
  String plannedArrival;
  String plannedDeparture;
  double plannedDistance;
  String plannedComplete;
  String plannedStart;
  List<LocationPendingPayments> locationPendingPayments;
  List<AdditionalMaterials> additionalMaterials;
  List<HolderMaterials> holderMaterials;
  List<Manifests> manifests;
  int totalStops;
  String status;
  int plannedServiceTime;
  bool hasPicture;
  int plannedSize1;
  int plannedSize2;
  int plannedSize3;
  int plannedPickupSize1;
  int plannedPickupSize2;
  int plannedPickupSize3;
  BaseUnitModel size1AliasConfig;
  BaseUnitModel size3AliasConfig;
  bool onRoute;

  RouteModel({
    this.id,
    this.organization,
    this.key,
    this.date,
    this.description,
    this.origin,
    this.origLatitude,
    this.origLongitude,
    this.destination,
    this.destLatitude,
    this.destLongitude,
    this.lastStopIsDestination,
    this.stops,
    this.plannedArrival,
    this.plannedDeparture,
    this.plannedDistance,
    this.plannedComplete,
    this.plannedStart,
    this.locationPendingPayments,
    this.additionalMaterials,
    this.holderMaterials,
    this.manifests,
    this.totalStops,
    this.status,
    this.plannedServiceTime,
    this.hasPicture,
    this.plannedSize1,
    this.plannedSize2,
    this.plannedSize3,
    this.plannedPickupSize1,
    this.plannedPickupSize2,
    this.plannedPickupSize3,
    this.size1AliasConfig,
    this.size3AliasConfig,
    this.onRoute,
  });

  RouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['organization'] != null
        ? OrganizationModel.fromJson(json['organization'])
        : null;
    key = json['key'];
    date = json['date'];
    description = json['description'];
    origin = json['origin'] != null
        ? LocationModel.fromJson(
            json['origin'],
          )
        : null;
    origLatitude = json['origLatitude'];
    origLongitude = json['origLongitude'];
    destination = json['destination'] != null
        ? LocationModel.fromJson(json['destination'])
        : null;
    destLatitude = json['destLatitude'];
    destLongitude = json['destLongitude'];
    lastStopIsDestination = json['lastStopIsDestination'];
    if (json['stops'] != null) {
      stops = <StopModel>[];
      json['stops'].forEach((v) {
        stops.add(StopModel.fromJson(v));
      });
    }
    plannedArrival = json['plannedArrival'];
    plannedDeparture = json['plannedDeparture'];
    plannedDistance = json['plannedDistance'];
    plannedComplete = json['plannedComplete'];
    plannedStart = json['plannedStart'];
    if (json['locationPendingPayments'] != null) {
      locationPendingPayments = <LocationPendingPayments>[];
      json['locationPendingPayments'].forEach((v) {
        locationPendingPayments.add(LocationPendingPayments.fromJson(v));
      });
    }
    if (json['additionalMaterials'] != null) {
      additionalMaterials = <AdditionalMaterials>[];
      json['additionalMaterials'].forEach((v) {
        additionalMaterials.add(AdditionalMaterials.fromJson(v));
      });
    }
    if (json['holderMaterials'] != null) {
      holderMaterials = <HolderMaterials>[];
      json['holderMaterials'].forEach((v) {
        holderMaterials.add(HolderMaterials.fromJson(v));
      });
    }
    if (json['manifests'] != null) {
      manifests = <Manifests>[];
      json['manifests'].forEach((v) {
        manifests.add(Manifests.fromJson(v));
      });
    }
    totalStops = json['totalStops'];
    status = json['status'];
    plannedServiceTime = json['plannedServiceTime'];
    hasPicture = json['hasPicture'];
    plannedSize1 = json['plannedSize1'];
    plannedSize2 = json['plannedSize2'];
    plannedSize3 = json['plannedSize3'];
    plannedPickupSize1 = json['plannedPickupSize1'];
    plannedPickupSize2 = json['plannedPickupSize2'];
    plannedPickupSize3 = json['plannedPickupSize3'];
    size1AliasConfig = json['size1AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size1AliasConfig'])
        : null;
    size3AliasConfig = json['size3AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size3AliasConfig'])
        : null;
    onRoute = json['onRoute'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (organization != null) {
      data['organization'] = organization.toJson();
    }
    data['key'] = key;
    data['date'] = date;
    data['description'] = description;
    if (origin != null) {
      data['origin'] = origin.toJson();
    }
    data['origLatitude'] = origLatitude;
    data['origLongitude'] = origLongitude;
    if (destination != null) {
      data['destination'] = destination.toJson();
    }
    data['destLatitude'] = destLatitude;
    data['destLongitude'] = destLongitude;
    data['lastStopIsDestination'] = lastStopIsDestination;
    if (stops != null) {
      data['stops'] = stops.map((v) => v.toJson()).toList();
    }
    data['plannedArrival'] = plannedArrival;
    data['plannedDeparture'] = plannedDeparture;
    data['plannedDistance'] = plannedDistance;
    data['plannedComplete'] = plannedComplete;
    data['plannedStart'] = plannedStart;
    if (locationPendingPayments != null) {
      data['locationPendingPayments'] =
          locationPendingPayments.map((v) => v.toJson()).toList();
    }
    if (additionalMaterials != null) {
      data['additionalMaterials'] =
          additionalMaterials.map((v) => v.toJson()).toList();
    }
    if (holderMaterials != null) {
      data['holderMaterials'] = holderMaterials.map((v) => v.toJson()).toList();
    }
    if (manifests != null) {
      data['manifests'] = manifests.map((v) => v.toJson()).toList();
    }
    data['totalStops'] = totalStops;
    data['status'] = status;
    data['plannedServiceTime'] = plannedServiceTime;
    data['hasPicture'] = hasPicture;
    data['plannedSize1'] = plannedSize1;
    data['plannedSize2'] = plannedSize2;
    data['plannedSize3'] = plannedSize3;
    data['plannedPickupSize1'] = plannedPickupSize1;
    data['plannedPickupSize2'] = plannedPickupSize2;
    data['plannedPickupSize3'] = plannedPickupSize3;
    if (size1AliasConfig != null) {
      data['size1AliasConfig'] = size1AliasConfig.toJson();
    }
    if (size3AliasConfig != null) {
      data['size3AliasConfig'] = size3AliasConfig.toJson();
    }
    data['onRoute'] = onRoute;
    return data;
  }
}

class HolderMaterials {
  int id;
  Sku sku;
  Transport transport;
  BaseUnit size1Alias;
  int size1Quantity;
  BaseUnit size2Alias;
  int size2Quantity;
  BaseUnit size3Alias;
  int size3Quantity;

  HolderMaterials(
      {this.id,
      this.sku,
      this.transport,
      this.size1Alias,
      this.size1Quantity,
      this.size2Alias,
      this.size2Quantity,
      this.size3Alias,
      this.size3Quantity});

  HolderMaterials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'] != null ? new Sku.fromJson(json['sku']) : null;
    transport = json['transport'] != null
        ? new Transport.fromJson(json['transport'])
        : null;
    size1Alias = json['size1Alias'] != null
        ? new BaseUnit.fromJson(json['size1Alias'])
        : null;
    size1Quantity = json['size1Quantity'];
    size2Alias = json['size2Alias'] != null
        ? new BaseUnit.fromJson(json['size2Alias'])
        : null;
    size2Quantity = json['size2Quantity'];
    size3Alias = json['size3Alias'] != null
        ? new BaseUnit.fromJson(json['size3Alias'])
        : null;
    size3Quantity = json['size3Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.sku != null) {
      data['sku'] = this.sku.toJson();
    }
    if (this.transport != null) {
      data['transport'] = this.transport.toJson();
    }
    if (this.size1Alias != null) {
      data['size1Alias'] = this.size1Alias.toJson();
    }
    data['size1Quantity'] = this.size1Quantity;
    if (this.size2Alias != null) {
      data['size2Alias'] = this.size2Alias.toJson();
    }
    data['size2Quantity'] = this.size2Quantity;
    if (this.size3Alias != null) {
      data['size3Alias'] = this.size3Alias.toJson();
    }
    data['size3Quantity'] = this.size3Quantity;
    return data;
  }
}

class Manifests {
  int id;
  Sku sku;
  Transport transport;
  int size1;
  BaseUnit size1Alias;
  List<Udfs> udfs;

  Manifests(
      {this.id,
      this.sku,
      this.transport,
      this.size1,
      this.size1Alias,
      this.udfs});

  Manifests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'] != null ? new Sku.fromJson(json['sku']) : null;
    transport = json['transport'] != null
        ? new Transport.fromJson(json['transport'])
        : null;
    size1 = json['size1'];
    size1Alias = json['size1Alias'] != null
        ? new BaseUnit.fromJson(json['size1Alias'])
        : null;
    if (json['udfs'] != null) {
      udfs = new List<Udfs>();
      json['udfs'].forEach((v) {
        udfs.add(new Udfs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.sku != null) {
      data['sku'] = this.sku.toJson();
    }
    if (this.transport != null) {
      data['transport'] = this.transport.toJson();
    }
    data['size1'] = this.size1;
    if (this.size1Alias != null) {
      data['size1Alias'] = this.size1Alias.toJson();
    }
    if (this.udfs != null) {
      data['udfs'] = this.udfs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sku {
  int id;
  Organization organization;
  String key;
  String description;
  Organization skuType;
  BaseUnit baseUnit;
  BaseUnit secondaryUnit;
  int secondaryQty;
  String alternativeKey;

  Sku(
      {this.id,
      this.organization,
      this.key,
      this.description,
      this.skuType,
      this.baseUnit,
      this.secondaryUnit,
      this.secondaryQty,
      this.alternativeKey});

  Sku.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    key = json['key'];
    description = json['description'];
    skuType = json['skuType'] != null
        ? new Organization.fromJson(json['skuType'])
        : null;
    baseUnit = json['baseUnit'] != null
        ? new BaseUnit.fromJson(json['baseUnit'])
        : null;
    secondaryUnit = json['secondaryUnit'] != null
        ? new BaseUnit.fromJson(json['secondaryUnit'])
        : null;
    secondaryQty = json['secondaryQty'];
    alternativeKey = json['alternativeKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.organization != null) {
      data['organization'] = this.organization.toJson();
    }
    data['key'] = this.key;
    data['description'] = this.description;
    if (this.skuType != null) {
      data['skuType'] = this.skuType.toJson();
    }
    if (this.baseUnit != null) {
      data['baseUnit'] = this.baseUnit.toJson();
    }
    if (this.secondaryUnit != null) {
      data['secondaryUnit'] = this.secondaryUnit.toJson();
    }
    data['secondaryQty'] = this.secondaryQty;
    data['alternativeKey'] = this.alternativeKey;
    return data;
  }
}

class FeatureStates {
  String name;
  bool enabled;
  Parameters parameters;

  FeatureStates({this.name, this.enabled, this.parameters});

  FeatureStates.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enabled = json['enabled'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['enabled'] = this.enabled;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.toJson();
    }
    return data;
  }
}

class Parameters {
  String url;

  Parameters({this.url});

  Parameters.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
