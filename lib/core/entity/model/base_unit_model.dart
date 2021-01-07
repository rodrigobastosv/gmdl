class BaseUnitModel {
  int id;
  String key;
  String description;
  String icon;
  String preferredSize;

  BaseUnitModel({
    this.id,
    this.key,
    this.description,
    this.icon,
    this.preferredSize,
  });

  BaseUnitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    description = json['description'];
    icon = json['icon'];
    preferredSize = json['preferredSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['description'] = description;
    data['icon'] = icon;
    data['preferredSize'] = preferredSize;
    return data;
  }
}
