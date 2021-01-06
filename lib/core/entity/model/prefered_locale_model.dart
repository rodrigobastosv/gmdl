class PreferedLocaleModel {
  int id;
  String key;
  String language;
  String description;
  String dateFormat;
  String timeFormat;
  String currency;
  String decimalSymbol;
  String digitalGrouping;

  PreferedLocaleModel(
      {this.id,
      this.key,
      this.language,
      this.description,
      this.dateFormat,
      this.timeFormat,
      this.currency,
      this.decimalSymbol,
      this.digitalGrouping});

  PreferedLocaleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    language = json['language'];
    description = json['description'];
    dateFormat = json['dateFormat'];
    timeFormat = json['timeFormat'];
    currency = json['currency'];
    decimalSymbol = json['decimalSymbol'];
    digitalGrouping = json['digitalGrouping'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['language'] = language;
    data['description'] = description;
    data['dateFormat'] = dateFormat;
    data['timeFormat'] = timeFormat;
    data['currency'] = currency;
    data['decimalSymbol'] = decimalSymbol;
    data['digitalGrouping'] = digitalGrouping;
    return data;
  }
}
