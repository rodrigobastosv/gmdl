class TimeZoneModel {
  int id;
  String description;
  int rawOffsetMinutes;
  String timezoneName;

  TimeZoneModel({
    this.id,
    this.description,
    this.rawOffsetMinutes,
    this.timezoneName,
  });

  TimeZoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    rawOffsetMinutes = json['rawOffsetMinutes'];
    timezoneName = json['timezoneName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['rawOffsetMinutes'] = rawOffsetMinutes;
    data['timezoneName'] = timezoneName;
    return data;
  }
}
