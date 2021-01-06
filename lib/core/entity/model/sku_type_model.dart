import 'organization_model.dart';

class SkuTypeModel {
  int id;
  String creationDate;
  OrganizationModel organization;
  String key;
  String description;

  SkuTypeModel(
      {this.id,
      this.creationDate,
      this.organization,
      this.key,
      this.description});

  SkuTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'];
    organization = json['organization'] != null
        ? OrganizationModel.fromJson(json['organization'])
        : null;
    key = json['key'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['creationDate'] = creationDate;
    if (organization != null) {
      data['organization'] = organization.toJson();
    }
    data['key'] = key;
    data['description'] = description;
    return data;
  }
}
