class StopTypeModel {
  int id;
  String key;
  String description;
  String type;
  bool locationRequired;

  StopTypeModel({
    this.id,
    this.key,
    this.description,
    this.type,
    this.locationRequired,
  });

  StopTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    description = json['description'];
    type = json['type'];
    locationRequired = json['locationRequired'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['description'] = description;
    data['type'] = type;
    data['locationRequired'] = locationRequired;
    return data;
  }
}
