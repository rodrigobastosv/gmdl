import '../serializing_utils.dart';
import 'models.dart';

class LineItemModel {
  int id;
  String key;
  String lineItemID;
  SkuModel sku;
  bool hasPicture;
  BaseUnitModel size1AliasConfig;
  BaseUnitModel size2AliasConfig;
  BaseUnitModel size3AliasConfig;
  double unitPrice;
  double totalPrice;
  String bonusKey;
  bool allowShort;
  List<UdfModel> udfs;
  double unitDiscountSize1;
  double plannedSize1;
  double plannedSize2;
  double plannedSize3;
  double plannedPickupSize1;
  double plannedPickupSize2;
  double unitTaxSize1;
  double unitTaxSize2;
  double unitTaxSize3;
  double damagedSize1;
  double damagedSize2;
  double damagedSize3;
  bool disregardInStock;

  LineItemModel({
    this.id,
    this.key,
    this.lineItemID,
    this.sku,
    this.plannedSize1,
    this.plannedSize2,
    this.hasPicture,
    this.size1AliasConfig,
    this.size2AliasConfig,
    this.size3AliasConfig,
    this.unitPrice,
    this.totalPrice,
    this.bonusKey,
    this.allowShort,
    this.udfs,
    this.unitTaxSize1,
    this.unitDiscountSize1,
    this.disregardInStock,
    this.plannedPickupSize1,
    this.plannedPickupSize2,
    this.damagedSize1,
    this.damagedSize2,
    this.unitTaxSize2,
    this.plannedSize3,
    this.unitTaxSize3,
    this.damagedSize3,
  });

  LineItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    lineItemID = json['lineItemID'];
    sku = json['sku'] != null ? SkuModel.fromJson(json['sku']) : null;
    plannedSize1 = json['plannedSize1'];
    plannedSize2 = json['plannedSize2'];
    hasPicture = json['hasPicture'];
    size1AliasConfig = json['size1AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size1AliasConfig'])
        : null;
    size2AliasConfig = json['size2AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size2AliasConfig'])
        : null;
    size3AliasConfig = json['size3AliasConfig'] != null
        ? BaseUnitModel.fromJson(json['size3AliasConfig'])
        : null;
    unitPrice = convertToDouble(json['unitPrice']);
    totalPrice = convertToDouble(json['totalPrice']);
    bonusKey = json['bonusKey'];
    allowShort = json['allowShort'];
    if (json['udfs'] != null) {
      udfs = <UdfModel>[];
      json['udfs'].forEach((v) {
        udfs.add(UdfModel.fromJson(v));
      });
    }
    unitTaxSize1 = json['unitTaxSize1'];
    unitDiscountSize1 = json['unitDiscountSize1'];
    disregardInStock = json['disregardInStock'];
    plannedPickupSize1 = convertToDouble(json['plannedPickupSize1']);
    plannedPickupSize2 = convertToDouble(json['plannedPickupSize2']);
    damagedSize1 = convertToDouble(json['damagedSize1']);
    damagedSize2 = convertToDouble(json['damagedSize2']);
    unitTaxSize2 = convertToDouble(json['unitTaxSize2']);
    plannedSize3 = convertToDouble(json['plannedSize3']);
    unitTaxSize3 = convertToDouble(json['unitTaxSize3']);
    damagedSize3 = convertToDouble(json['damagedSize3']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['lineItemID'] = lineItemID;
    if (sku != null) {
      data['sku'] = sku.toJson();
    }
    data['plannedSize1'] = plannedSize1;
    data['plannedSize2'] = plannedSize2;
    data['hasPicture'] = hasPicture;
    if (size1AliasConfig != null) {
      data['size1AliasConfig'] = size1AliasConfig.toJson();
    }
    if (size2AliasConfig != null) {
      data['size2AliasConfig'] = size2AliasConfig.toJson();
    }
    if (size3AliasConfig != null) {
      data['size3AliasConfig'] = size3AliasConfig.toJson();
    }
    data['unitPrice'] = unitPrice;
    data['totalPrice'] = totalPrice;
    data['bonusKey'] = bonusKey;
    data['allowShort'] = allowShort;
    if (udfs != null) {
      data['udfs'] = udfs.map((v) => v.toJson()).toList();
    }
    data['unitTaxSize1'] = unitTaxSize1;
    data['unitDiscountSize1'] = unitDiscountSize1;
    data['disregardInStock'] = disregardInStock;
    data['plannedPickupSize1'] = plannedPickupSize1;
    data['plannedPickupSize2'] = plannedPickupSize2;
    data['damagedSize1'] = damagedSize1;
    data['damagedSize2'] = damagedSize2;
    data['unitTaxSize2'] = unitTaxSize2;
    data['plannedSize3'] = plannedSize3;
    data['unitTaxSize3'] = unitTaxSize3;
    data['damagedSize3'] = damagedSize3;
    return data;
  }
}
