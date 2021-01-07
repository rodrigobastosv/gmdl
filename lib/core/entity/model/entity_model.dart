class EntityModel {
  int id;
  bool hasPicture;

  EntityModel({
    this.id,
    this.hasPicture,
  });

  EntityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasPicture = json['hasPicture'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['hasPicture'] = hasPicture;
    return data;
  }
}
