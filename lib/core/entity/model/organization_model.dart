import 'models.dart';

class OrganizationModel {
  int id;
  String creationDate;
  String key;
  OrganizationModel parentOrganization;
  String description;
  PreferedLocaleModel preferedLocale;
  TimeZoneModel timeZone;
  String unitSystem;

  OrganizationModel({
    this.id,
    this.creationDate,
    this.key,
    this.parentOrganization,
    this.description,
    this.preferedLocale,
    this.timeZone,
    this.unitSystem,
  });

  OrganizationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creationDate'];
    key = json['key'];
    parentOrganization = json['parentOrganization'] != null
        ? OrganizationModel.fromJson(json['parentOrganization'])
        : null;
    description = json['description'];
    preferedLocale = json['preferedLocale'] != null
        ? PreferedLocaleModel.fromJson(json['preferedLocale'])
        : null;
    timeZone = json['timeZone'] != null
        ? TimeZoneModel.fromJson(json['timeZone'])
        : null;
    unitSystem = json['unitSystem'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['creationDate'] = creationDate;
    data['key'] = key;
    if (parentOrganization != null) {
      data['parentOrganization'] = parentOrganization.toJson();
    }
    data['description'] = description;
    if (preferedLocale != null) {
      data['preferedLocale'] = preferedLocale.toJson();
    }
    if (timeZone != null) {
      data['timeZone'] = timeZone.toJson();
    }
    data['unitSystem'] = unitSystem;
    return data;
  }
}
