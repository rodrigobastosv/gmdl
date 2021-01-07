import 'models.dart';

class ManifestModel {
  int id;
  SkuModel sku;
  TransportModel transport;
  int size1;
  BaseUnitModel size1Alias;
  List<UdfModel> udfs;

  ManifestModel({
    this.id,
    this.sku,
    this.transport,
    this.size1,
    this.size1Alias,
    this.udfs,
  });

  ManifestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'] != null ? SkuModel.fromJson(json['sku']) : null;
    transport = json['transport'] != null
        ? TransportModel.fromJson(json['transport'])
        : null;
    size1 = json['size1'];
    size1Alias = json['size1Alias'] != null
        ? BaseUnitModel.fromJson(json['size1Alias'])
        : null;
    if (json['udfs'] != null) {
      udfs = <UdfModel>[];
      json['udfs'].forEach((v) {
        udfs.add(UdfModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (sku != null) {
      data['sku'] = sku.toJson();
    }
    if (transport != null) {
      data['transport'] = transport.toJson();
    }
    data['size1'] = size1;
    if (size1Alias != null) {
      data['size1Alias'] = size1Alias.toJson();
    }
    if (udfs != null) {
      data['udfs'] = udfs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
