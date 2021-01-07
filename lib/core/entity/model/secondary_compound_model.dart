import '../serializing_utils.dart';
import 'models.dart';

class SecondaryCompoundModel {
  int id;
  String creationDate;
  String lastModificationDate;
  OrganizationModel organization;
  String key;
  String description;
  bool enabled;
  OrganizationModel skuType;
  BaseUnitModel baseUnit;
  double secondaryQty;
  String alternativeKey;
  bool hasSecondaryBundle;
  bool hasTertiaryBundle;

  SecondaryCompoundModel({
    this.id,
    this.creationDate,
    this.lastModificationDate,
    this.organization,
    this.key,
    this.description,
    this.enabled,
    this.skuType,
    this.baseUnit,
    this.secondaryQty,
    this.alternativeKey,
    this.hasSecondaryBundle,
    this.hasTertiaryBundle,
  });

  SecondaryCompoundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'];
    lastModificationDate = json['lastModificationDate'];
    organization = json['organization'] != null
        ? OrganizationModel.fromJson(json['organization'])
        : null;
    key = json['key'];
    description = json['description'];
    enabled = json['enabled'];
    skuType = json['skuType'] != null
        ? OrganizationModel.fromJson(json['skuType'])
        : null;
    baseUnit = json['baseUnit'] != null
        ? BaseUnitModel.fromJson(json['baseUnit'])
        : null;
    secondaryQty = convertToDouble(json['secondaryQty']);
    alternativeKey = json['alternativeKey'];
    hasSecondaryBundle = json['hasSecondaryBundle'];
    hasTertiaryBundle = json['hasTertiaryBundle'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['creationDate'] = creationDate;
    data['lastModificationDate'] = lastModificationDate;
    if (organization != null) {
      data['organization'] = organization.toJson();
    }
    data['key'] = key;
    data['description'] = description;
    data['enabled'] = enabled;
    if (skuType != null) {
      data['skuType'] = skuType.toJson();
    }
    if (baseUnit != null) {
      data['baseUnit'] = baseUnit.toJson();
    }
    data['secondaryQty'] = secondaryQty;
    data['alternativeKey'] = alternativeKey;
    data['hasSecondaryBundle'] = hasSecondaryBundle;
    data['hasTertiaryBundle'] = hasTertiaryBundle;
    return data;
  }
}
