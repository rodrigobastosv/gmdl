class RouteDTO {
  String key;
  String date;

  RouteDTO({
    this.key,
    this.date,
  });

  RouteDTO.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = {};
    data['key'] = key;
    data['date'] = date;
    return data;
  }
}
