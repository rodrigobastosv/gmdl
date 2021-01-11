import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../serializing_utils.dart';
import 'models.dart';

@immutable
// ignore: must_be_immutable
class StopModel extends Equatable {
  int id;
  String key;
  RouteModel route;
  List<OrderModel> orders;
  List<StopDocumentModel> stopDocuments;
  LocationModel location;
  int plannedSequenceNum;
  StopTypeModel stopType;
  TransportModel transport;
  String plannedArrival;
  String projectedArrival;
  String actualDeparture;
  String plannedDeparture;
  String projectedDeparture;
  double plannedSize1;
  double plannedSize2;
  double plannedSize3;
  double plannedPickupSize1;
  double plannedPickupSize2;
  double plannedPickupSize3;
  bool hasPicture;
  bool hasSignature;
  double longitude;
  double latitude;
  String ordersInfo;
  BaseUnitModel size1AliasConfig;
  BaseUnitModel size2AliasConfig;
  BaseUnitModel size3AliasConfig;
  bool returned;
  bool redelivered;
  bool canceled;
  double damagedSize1;
  double damagedSize2;
  double damagedSize3;

  StopModel({
    this.id,
    this.key,
    this.route,
    this.orders,
    this.stopDocuments,
    this.location,
    this.plannedSequenceNum,
    this.stopType,
    this.transport,
    this.plannedArrival,
    this.projectedArrival,
    this.actualDeparture,
    this.plannedDeparture,
    this.projectedDeparture,
    this.plannedSize1,
    this.plannedSize2,
    this.plannedSize3,
    this.plannedPickupSize1,
    this.plannedPickupSize2,
    this.plannedPickupSize3,
    this.hasPicture,
    this.hasSignature,
    this.longitude,
    this.latitude,
    this.ordersInfo,
    this.size1AliasConfig,
    this.size2AliasConfig,
    this.size3AliasConfig,
    this.returned,
    this.redelivered,
    this.canceled,
    this.damagedSize1,
    this.damagedSize2,
    this.damagedSize3,
  });

  StopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    if (json['orders'] != null) {
      orders = <OrderModel>[];
      json['orders'].forEach((v) {
        orders.add(OrderModel.fromJson(v));
      });
    }
    if (json['stopDocuments'] != null) {
      stopDocuments = <StopDocumentModel>[];
      json['stopDocuments'].forEach((v) {
        stopDocuments.add(StopDocumentModel.fromJson(v));
      });
    }
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    plannedSequenceNum = json['plannedSequenceNum'];
    stopType = json['stopType'] != null
        ? StopTypeModel.fromJson(json['stopType'])
        : null;
    transport = json['transport'] != null
        ? TransportModel.fromJson(json['transport'])
        : null;
    plannedArrival = json['plannedArrival'];
    projectedArrival = json['projectedArrival'];
    actualDeparture = json['actualDeparture'];
    plannedDeparture = json['plannedDeparture'];
    projectedDeparture = json['projectedDeparture'];
    plannedSize1 = convertToDouble(json['plannedSize1']);
    plannedSize2 = convertToDouble(json['plannedSize2']);
    plannedSize3 = convertToDouble(json['plannedSize3']);
    plannedPickupSize1 = convertToDouble(json['plannedPickupSize1']);
    plannedPickupSize2 = convertToDouble(json['plannedPickupSize2']);
    plannedPickupSize3 = convertToDouble(json['plannedPickupSize3']);
    hasPicture = json['hasPicture'];
    hasSignature = json['hasSignature'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    ordersInfo = json['ordersInfo'];
    size1AliasConfig = json['size1AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size1AliasConfig'])
        : null;
    size2AliasConfig = json['size2AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size2AliasConfig'])
        : null;
    size3AliasConfig = json['size3AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size3AliasConfig'])
        : null;
    returned = json['returned'];
    redelivered = json['redelivered'];
    canceled = json['canceled'];
    damagedSize1 = convertToDouble(json['damagedSize1']);
    damagedSize2 = convertToDouble(json['damagedSize2']);
    damagedSize3 = convertToDouble(json['damagedSize3']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    if (route != null) {
      data['route'] = route.toJson();
    }
    if (orders != null) {
      data['orders'] = orders.map((v) => v.toJson()).toList();
    }
    if (stopDocuments != null) {
      data['stopDocuments'] = stopDocuments.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      data['location'] = location.toJson();
    }
    data['plannedSequenceNum'] = plannedSequenceNum;
    if (stopType != null) {
      data['stopType'] = stopType.toJson();
    }
    if (transport != null) {
      data['transport'] = transport.toJson();
    }
    data['plannedArrival'] = plannedArrival;
    data['projectedArrival'] = projectedArrival;
    data['actualDeparture'] = actualDeparture;
    data['plannedDeparture'] = plannedDeparture;
    data['projectedDeparture'] = projectedDeparture;
    data['plannedSize1'] = plannedSize1;
    data['plannedSize2'] = plannedSize2;
    data['plannedSize3'] = plannedSize3;
    data['plannedPickupSize1'] = plannedPickupSize1;
    data['plannedPickupSize2'] = plannedPickupSize2;
    data['plannedPickupSize3'] = plannedPickupSize3;
    data['hasPicture'] = hasPicture;
    data['hasSignature'] = hasSignature;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['ordersInfo'] = ordersInfo;
    if (size1AliasConfig != null) {
      data['size1AliasConfig'] = size1AliasConfig.toJson();
    }
    if (size2AliasConfig != null) {
      data['size2AliasConfig'] = size2AliasConfig.toJson();
    }
    if (size3AliasConfig != null) {
      data['size3AliasConfig'] = size3AliasConfig.toJson();
    }
    data['returned'] = returned;
    data['redelivered'] = redelivered;
    data['canceled'] = canceled;
    data['damagedSize1'] = damagedSize1;
    data['damagedSize2'] = damagedSize2;
    data['damagedSize3'] = damagedSize3;
    return data;
  }

  StopModel copyWith({
    int id,
    String key,
    RouteModel route,
    List<OrderModel> orders,
    List<StopDocumentModel> stopDocuments,
    LocationModel location,
    int plannedSequenceNum,
    StopTypeModel stopType,
    TransportModel transport,
    String plannedArrival,
    String projectedArrival,
    String actualDeparture,
    String plannedDeparture,
    String projectedDeparture,
    double plannedSize1,
    double plannedSize2,
    double plannedSize3,
    double plannedPickupSize1,
    double plannedPickupSize2,
    double plannedPickupSize3,
    bool hasPicture,
    bool hasSignature,
    double longitude,
    double latitude,
    String ordersInfo,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size2AliasConfig,
    BaseUnitModel size3AliasConfig,
    bool returned,
    bool redelivered,
    bool canceled,
    double damagedSize1,
    double damagedSize2,
    double damagedSize3,
  }) {
    return StopModel(
      id: id ?? this.id,
      key: key ?? this.key,
      route: route ?? this.route,
      orders: orders ?? this.orders,
      stopDocuments: stopDocuments ?? this.stopDocuments,
      location: location ?? this.location,
      plannedSequenceNum: plannedSequenceNum ?? this.plannedSequenceNum,
      stopType: stopType ?? this.stopType,
      transport: transport ?? this.transport,
      plannedArrival: plannedArrival ?? this.plannedArrival,
      projectedArrival: projectedArrival ?? this.projectedArrival,
      actualDeparture: actualDeparture ?? this.actualDeparture,
      plannedDeparture: plannedDeparture ?? this.plannedDeparture,
      projectedDeparture: projectedDeparture ?? this.projectedDeparture,
      plannedSize1: plannedSize1 ?? this.plannedSize1,
      plannedSize2: plannedSize2 ?? this.plannedSize2,
      plannedSize3: plannedSize3 ?? this.plannedSize3,
      plannedPickupSize1: plannedPickupSize1 ?? this.plannedPickupSize1,
      plannedPickupSize2: plannedPickupSize2 ?? this.plannedPickupSize2,
      plannedPickupSize3: plannedPickupSize3 ?? this.plannedPickupSize3,
      hasPicture: hasPicture ?? this.hasPicture,
      hasSignature: hasSignature ?? this.hasSignature,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      ordersInfo: ordersInfo ?? this.ordersInfo,
      size1AliasConfig: size1AliasConfig ?? this.size1AliasConfig,
      size2AliasConfig: size2AliasConfig ?? this.size2AliasConfig,
      size3AliasConfig: size3AliasConfig ?? this.size3AliasConfig,
      returned: returned ?? this.returned,
      redelivered: redelivered ?? this.redelivered,
      canceled: canceled ?? this.canceled,
      damagedSize1: damagedSize1 ?? this.damagedSize1,
      damagedSize2: damagedSize2 ?? this.damagedSize2,
      damagedSize3: damagedSize3 ?? this.damagedSize3,
    );
  }

  @override
  List<Object> get props => [
        id.hashCode,
        key.hashCode,
        route.hashCode,
        orders.hashCode,
        stopDocuments.hashCode,
        location.hashCode,
        plannedSequenceNum.hashCode,
        stopType.hashCode,
        transport.hashCode,
        plannedArrival.hashCode,
        projectedArrival.hashCode,
        actualDeparture.hashCode,
        plannedDeparture.hashCode,
        projectedDeparture.hashCode,
        plannedSize1.hashCode,
        plannedSize2.hashCode,
        plannedSize3.hashCode,
        plannedPickupSize1.hashCode,
        plannedPickupSize2.hashCode,
        plannedPickupSize3.hashCode,
        hasPicture.hashCode,
        hasSignature.hashCode,
        longitude.hashCode,
        latitude.hashCode,
        ordersInfo.hashCode,
        size1AliasConfig.hashCode,
        size2AliasConfig.hashCode,
        size3AliasConfig.hashCode,
        returned.hashCode,
        redelivered.hashCode,
        canceled.hashCode,
        damagedSize1.hashCode,
        damagedSize2.hashCode,
        damagedSize3.hashCode,
      ];
}
