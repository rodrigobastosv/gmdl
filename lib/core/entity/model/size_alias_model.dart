class SizeAliasModel {
  int id;
  String key;
  String preferredSize;

  SizeAliasModel({
    this.id,
    this.key,
    this.preferredSize,
  });

  SizeAliasModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    preferredSize = json['preferredSize'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['preferredSize'] = preferredSize;
    return data;
  }
}
