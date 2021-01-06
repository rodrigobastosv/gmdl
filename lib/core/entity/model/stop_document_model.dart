class StopDocumentModel {
  int id;
  String documentDescription;
  String documentNumber;

  StopDocumentModel({
    this.id,
    this.documentDescription,
    this.documentNumber,
  });

  StopDocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentDescription = json['documentDescription'];
    documentNumber = json['documentNumber'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['documentDescription'] = documentDescription;
    data['documentNumber'] = documentNumber;
    return data;
  }
}
