class LocationTypeModel {
  int id;
  String key;
  String description;
  bool showOnMobileCreate;
  String alternativeKey;

  LocationTypeModel({
    this.id,
    this.key,
    this.description,
    this.showOnMobileCreate,
    this.alternativeKey,
  });

  LocationTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    description = json['description'];
    showOnMobileCreate = json['showOnMobileCreate'];
    alternativeKey = json['alternativeKey'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['description'] = description;
    data['showOnMobileCreate'] = showOnMobileCreate;
    data['alternativeKey'] = alternativeKey;
    return data;
  }
}
