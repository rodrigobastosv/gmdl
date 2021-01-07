import 'models.dart';

class HolderMaterialModel {
  int id;
  SkuModel sku;
  TransportModel transport;
  BaseUnitModel size1Alias;
  int size1Quantity;
  BaseUnitModel size2Alias;
  int size2Quantity;
  BaseUnitModel size3Alias;
  int size3Quantity;

  HolderMaterialModel({
    this.id,
    this.sku,
    this.transport,
    this.size1Alias,
    this.size1Quantity,
    this.size2Alias,
    this.size2Quantity,
    this.size3Alias,
    this.size3Quantity,
  });

  HolderMaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'] != null ? SkuModel.fromJson(json['sku']) : null;
    transport = json['transport'] != null
        ? TransportModel.fromJson(json['transport'])
        : null;
    size1Alias = json['size1Alias'] != null
        ? BaseUnitModel.fromJson(json['size1Alias'])
        : null;
    size1Quantity = json['size1Quantity'];
    size2Alias = json['size2Alias'] != null
        ? BaseUnitModel.fromJson(json['size2Alias'])
        : null;
    size2Quantity = json['size2Quantity'];
    size3Alias = json['size3Alias'] != null
        ? BaseUnitModel.fromJson(json['size3Alias'])
        : null;
    size3Quantity = json['size3Quantity'];
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
    if (size1Alias != null) {
      data['size1Alias'] = size1Alias.toJson();
    }
    data['size1Quantity'] = size1Quantity;
    if (size2Alias != null) {
      data['size2Alias'] = size2Alias.toJson();
    }
    data['size2Quantity'] = size2Quantity;
    if (size3Alias != null) {
      data['size3Alias'] = size3Alias.toJson();
    }
    data['size3Quantity'] = size3Quantity;
    return data;
  }
}
