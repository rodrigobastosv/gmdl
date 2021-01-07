import 'models.dart';

class SkuModel {
  int id;
  OrganizationModel organization;
  String key;
  String description;
  SkuTypeModel skuType;
  BaseUnitModel baseUnit;
  BaseUnitModel secondaryUnit;
  int secondaryQty;
  String alternativeKey;
  SecondaryCompoundModel secondaryCompound;
  int secondaryCompoundQty;

  SkuModel({
    this.id,
    this.organization,
    this.key,
    this.description,
    this.skuType,
    this.baseUnit,
    this.secondaryUnit,
    this.secondaryQty,
    this.alternativeKey,
    this.secondaryCompound,
    this.secondaryCompoundQty,
  });

  SkuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['organization'] != null
        ? OrganizationModel.fromJson(json['organization'])
        : null;
    key = json['key'];
    description = json['description'];
    skuType =
        json['skuType'] != null ? SkuTypeModel.fromJson(json['skuType']) : null;
    baseUnit = json['baseUnit'] != null
        ? BaseUnitModel.fromJson(json['baseUnit'])
        : null;
    secondaryUnit = json['secondaryUnit'] != null
        ? BaseUnitModel.fromJson(json['secondaryUnit'])
        : null;
    secondaryQty = json['secondaryQty'];
    alternativeKey = json['alternativeKey'];
    secondaryCompound = json['secondaryCompound'] != null
        ? SecondaryCompoundModel.fromJson(json['secondaryCompound'])
        : null;
    secondaryCompoundQty = json['secondaryCompoundQty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (organization != null) {
      data['organization'] = organization.toJson();
    }
    data['key'] = key;
    data['description'] = description;
    if (skuType != null) {
      data['skuType'] = skuType.toJson();
    }
    if (baseUnit != null) {
      data['baseUnit'] = baseUnit.toJson();
    }
    if (secondaryUnit != null) {
      data['secondaryUnit'] = secondaryUnit.toJson();
    }
    data['secondaryQty'] = secondaryQty;
    data['alternativeKey'] = alternativeKey;
    if (secondaryCompound != null) {
      data['secondaryCompound'] = secondaryCompound.toJson();
    }
    data['secondaryCompoundQty'] = secondaryCompoundQty;
    return data;
  }
}
