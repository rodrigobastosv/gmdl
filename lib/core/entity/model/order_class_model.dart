class OrderClassModel {
  int id;
  String key;
  String description;
  bool allDamaged;

  OrderClassModel({
    this.id,
    this.key,
    this.description,
    this.allDamaged,
  });

  OrderClassModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    description = json['description'];
    allDamaged = json['allDamaged'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['description'] = description;
    data['allDamaged'] = allDamaged;
    return data;
  }
}
