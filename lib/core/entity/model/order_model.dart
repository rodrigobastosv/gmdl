import 'models.dart';

class OrderModel {
  int id;
  String number;
  List<LineItemModel> lineItems;
  double plannedSize1;
  double plannedSize2;
  double plannedSize3;
  double plannedPickupSize1;
  double plannedPickupSize2;
  double plannedPickupSize3;
  List<UdfModel> udfs;
  bool hasPicture;
  PaymentMethodModel paymentMethod;
  BaseUnitModel size1AliasConfig;
  BaseUnitModel size2AliasConfig;
  BaseUnitModel size3AliasConfig;
  bool allowShort;
  bool newOrder;
  OrderClassModel orderClass;
  double damagedSize1;
  double damagedSize2;
  double damagedSize3;

  OrderModel({
    this.id,
    this.number,
    this.lineItems,
    this.plannedSize1,
    this.plannedSize2,
    this.plannedSize3,
    this.plannedPickupSize1,
    this.plannedPickupSize2,
    this.plannedPickupSize3,
    this.udfs,
    this.hasPicture,
    this.paymentMethod,
    this.size1AliasConfig,
    this.size2AliasConfig,
    this.size3AliasConfig,
    this.allowShort,
    this.newOrder,
    this.orderClass,
    this.damagedSize1,
    this.damagedSize2,
    this.damagedSize3,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    if (json['lineItems'] != null) {
      lineItems = <LineItemModel>[];
      json['lineItems'].forEach((v) {
        lineItems.add(LineItemModel.fromJson(v));
      });
    }
    plannedSize1 = json['plannedSize1'];
    plannedSize2 = json['plannedSize2'];
    plannedSize3 = json['plannedSize3'];
    plannedPickupSize1 = json['plannedPickupSize1'];
    plannedPickupSize2 = json['plannedPickupSize2'];
    plannedPickupSize3 = json['plannedPickupSize3'];
    if (json['udfs'] != null) {
      udfs = <UdfModel>[];
      json['udfs'].forEach((v) {
        udfs.add(UdfModel.fromJson(v));
      });
    }
    hasPicture = json['hasPicture'];
    paymentMethod = json['paymentMethod'] != null
        ? PaymentMethodModel.fromJson(json['paymentMethod'])
        : null;
    size1AliasConfig = json['size1AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size1AliasConfig'])
        : null;
    size2AliasConfig = json['size2AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size2AliasConfig'])
        : null;
    size3AliasConfig = json['size3AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size3AliasConfig'])
        : null;
    allowShort = json['allowShort'];
    newOrder = json['newOrder'];
    orderClass = json['orderClass'] != null
        ? OrderClassModel.fromJson(json['orderClass'])
        : null;
    damagedSize1 = json['damagedSize1'];
    damagedSize2 = json['damagedSize2'];
    damagedSize3 = json['damagedSize3'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    if (lineItems != null) {
      data['lineItems'] = lineItems.map((v) => v.toJson()).toList();
    }
    data['plannedSize1'] = plannedSize1;
    data['plannedSize2'] = plannedSize2;
    data['plannedSize3'] = plannedSize3;
    data['plannedPickupSize1'] = plannedPickupSize1;
    data['plannedPickupSize2'] = plannedPickupSize2;
    data['plannedPickupSize3'] = plannedPickupSize3;
    if (udfs != null) {
      data['udfs'] = udfs.map((v) => v.toJson()).toList();
    }
    data['hasPicture'] = hasPicture;
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod.toJson();
    }
    if (size1AliasConfig != null) {
      data['size1AliasConfig'] = size1AliasConfig.toJson();
    }
    if (size2AliasConfig != null) {
      data['size2AliasConfig'] = size2AliasConfig.toJson();
    }
    if (size3AliasConfig != null) {
      data['size3AliasConfig'] = size3AliasConfig.toJson();
    }
    data['allowShort'] = allowShort;
    data['newOrder'] = newOrder;
    if (orderClass != null) {
      data['orderClass'] = orderClass.toJson();
    }
    data['damagedSize1'] = damagedSize1;
    data['damagedSize2'] = damagedSize2;
    data['damagedSize3'] = damagedSize3;
    return data;
  }
}
