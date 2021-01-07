import 'models.dart';

class UdfModel {
  int id;
  String key;
  EntityModel entity;
  String value;

  UdfModel({
    this.id,
    this.key,
    this.entity,
    this.value,
  });

  UdfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    entity =
        json['entity'] != null ? EntityModel.fromJson(json['entity']) : null;
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    if (entity != null) {
      data['entity'] = entity.toJson();
    }
    data['value'] = value;
    return data;
  }
}
