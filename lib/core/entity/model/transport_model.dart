class TransportModel {
  int id;
  String key;
  String date;
  String alternativeKey;

  TransportModel({
    this.id,
    this.key,
    this.date,
    this.alternativeKey,
  });

  TransportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    date = json['date'];
    alternativeKey = json['alternativeKey'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['date'] = date;
    data['alternativeKey'] = alternativeKey;
    return data;
  }
}
