import '../serializing_utils.dart';
import 'models.dart';

class HolderMaterialModel {
  int id;
  SkuModel sku;
  TransportModel transport;
  double size1Quantity;
  double size2Quantity;
  double size3Quantity;
  BaseUnitModel size1Alias;
  BaseUnitModel size2Alias;
  BaseUnitModel size3Alias;

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
    size1Quantity = convertToDouble(json['size1Quantity']);
    size2Quantity = convertToDouble(json['size2Quantity']);
    size3Quantity = convertToDouble(json['size3Quantity']);
    size1Alias = json['size1Alias'] != null
        ? BaseUnitModel.fromJson(json['size1Alias'])
        : null;
    size2Alias = json['size2Alias'] != null
        ? BaseUnitModel.fromJson(json['size2Alias'])
        : null;

    size3Alias = json['size3Alias'] != null
        ? BaseUnitModel.fromJson(json['size3Alias'])
        : null;
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
