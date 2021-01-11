import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../serializing_utils.dart';
import 'models.dart';

@immutable
// ignore: must_be_immutable
class RouteModel extends Equatable {
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
  List<LocationPendingPaymentModel> locationPendingPayments;
  List<AdditionalMaterialModel> additionalMaterials;
  List<HolderMaterialModel> holderMaterials;
  List<ManifestModel> manifests;
  int totalStops;
  String status;
  int plannedServiceTime;
  bool hasPicture;
  double plannedSize1;
  double plannedSize2;
  double plannedSize3;
  double plannedPickupSize1;
  double plannedPickupSize2;
  double plannedPickupSize3;
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
      locationPendingPayments = <LocationPendingPaymentModel>[];
      json['locationPendingPayments'].forEach((v) {
        locationPendingPayments.add(LocationPendingPaymentModel.fromJson(v));
      });
    }
    if (json['additionalMaterials'] != null) {
      additionalMaterials = <AdditionalMaterialModel>[];
      json['additionalMaterials'].forEach((v) {
        additionalMaterials.add(AdditionalMaterialModel.fromJson(v));
      });
    }
    if (json['holderMaterials'] != null) {
      holderMaterials = <HolderMaterialModel>[];
      json['holderMaterials'].forEach((v) {
        holderMaterials.add(HolderMaterialModel.fromJson(v));
      });
    }
    if (json['manifests'] != null) {
      manifests = <ManifestModel>[];
      json['manifests'].forEach((v) {
        manifests.add(ManifestModel.fromJson(v));
      });
    }
    totalStops = json['totalStops'];
    status = json['status'];
    plannedServiceTime = json['plannedServiceTime'];
    hasPicture = json['hasPicture'];
    plannedSize1 = convertToDouble(json['plannedSize1']);
    plannedSize2 = convertToDouble(json['plannedSize2']);
    plannedSize3 = convertToDouble(json['plannedSize3']);
    plannedPickupSize1 = convertToDouble(json['plannedPickupSize1']);
    plannedPickupSize2 = convertToDouble(json['plannedPickupSize2']);
    plannedPickupSize3 = convertToDouble(json['plannedPickupSize3']);
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

  RouteModel copyWith({
    int id,
    OrganizationModel organization,
    String key,
    String date,
    String description,
    LocationModel origin,
    double origLatitude,
    double origLongitude,
    LocationModel destination,
    double destLatitude,
    double destLongitude,
    bool lastStopIsDestination,
    List<StopModel> stops,
    String plannedArrival,
    String plannedDeparture,
    double plannedDistance,
    String plannedComplete,
    String plannedStart,
    List<LocationPendingPaymentModel> locationPendingPayments,
    List<AdditionalMaterialModel> additionalMaterials,
    List<HolderMaterialModel> holderMaterials,
    List<ManifestModel> manifests,
    int totalStops,
    String status,
    int plannedServiceTime,
    bool hasPicture,
    double plannedSize1,
    double plannedSize2,
    double plannedSize3,
    double plannedPickupSize1,
    double plannedPickupSize2,
    double plannedPickupSize3,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size3AliasConfig,
    bool onRoute,
  }) {
    return RouteModel(
      id: id ?? this.id,
      organization: organization ?? this.organization,
      key: key ?? this.key,
      date: date ?? this.date,
      description: description ?? this.description,
      origin: origin ?? this.origin,
      origLatitude: origLatitude ?? this.origLatitude,
      origLongitude: origLongitude ?? this.origLongitude,
      destination: destination ?? this.destination,
      destLatitude: destLatitude ?? this.destLatitude,
      destLongitude: destLongitude ?? this.destLongitude,
      lastStopIsDestination:
          lastStopIsDestination ?? this.lastStopIsDestination,
      stops: stops ?? this.stops,
      plannedArrival: plannedArrival ?? this.plannedArrival,
      plannedDeparture: plannedDeparture ?? this.plannedDeparture,
      plannedDistance: plannedDistance ?? this.plannedDistance,
      plannedComplete: plannedComplete ?? this.plannedComplete,
      plannedStart: plannedStart ?? this.plannedStart,
      locationPendingPayments:
          locationPendingPayments ?? this.locationPendingPayments,
      additionalMaterials: additionalMaterials ?? this.additionalMaterials,
      holderMaterials: holderMaterials ?? this.holderMaterials,
      manifests: manifests ?? this.manifests,
      totalStops: totalStops ?? this.totalStops,
      status: status ?? this.status,
      plannedServiceTime: plannedServiceTime ?? this.plannedServiceTime,
      hasPicture: hasPicture ?? this.hasPicture,
      plannedSize1: plannedSize1 ?? this.plannedSize1,
      plannedSize2: plannedSize2 ?? this.plannedSize2,
      plannedSize3: plannedSize3 ?? this.plannedSize3,
      plannedPickupSize1: plannedPickupSize1 ?? this.plannedPickupSize1,
      plannedPickupSize2: plannedPickupSize2 ?? this.plannedPickupSize2,
      plannedPickupSize3: plannedPickupSize3 ?? this.plannedPickupSize3,
      size1AliasConfig: size1AliasConfig ?? this.size1AliasConfig,
      size3AliasConfig: size3AliasConfig ?? this.size3AliasConfig,
      onRoute: onRoute ?? this.onRoute,
    );
  }

  @override
  List<Object> get props => [
        id.hashCode,
        organization.hashCode,
        key.hashCode,
        date.hashCode,
        description.hashCode,
        origin.hashCode,
        origLatitude.hashCode,
        origLongitude.hashCode,
        destination.hashCode,
        destLatitude.hashCode,
        destLongitude.hashCode,
        lastStopIsDestination.hashCode,
        stops.hashCode,
        plannedArrival.hashCode,
        plannedDeparture.hashCode,
        plannedDistance.hashCode,
        plannedComplete.hashCode,
        plannedStart.hashCode,
        locationPendingPayments.hashCode,
        additionalMaterials.hashCode,
        holderMaterials.hashCode,
        manifests.hashCode,
        totalStops.hashCode,
        status.hashCode,
        plannedServiceTime.hashCode,
        hasPicture.hashCode,
        plannedSize1.hashCode,
        plannedSize2.hashCode,
        plannedSize3.hashCode,
        plannedPickupSize1.hashCode,
        plannedPickupSize2.hashCode,
        plannedPickupSize3.hashCode,
        size1AliasConfig.hashCode,
        size3AliasConfig.hashCode,
        onRoute.hashCode,
      ];
}
