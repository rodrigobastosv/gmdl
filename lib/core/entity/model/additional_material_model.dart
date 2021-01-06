import 'size_alias_model.dart';
import 'sku_model.dart';
import 'transport_model.dart';

class AdditionalMaterialModel {
  int id;
  SkuModel sku;
  TransportModel transport;
  int quantity;
  SizeAliasModel sizeAlias;

  AdditionalMaterialModel({
    this.id,
    this.sku,
    this.transport,
    this.quantity,
    this.sizeAlias,
  });

  AdditionalMaterialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'] != null ? SkuModel.fromJson(json['sku']) : null;
    transport = json['transport'] != null
        ? TransportModel.fromJson(json['transport'])
        : null;
    quantity = json['quantity'];
    sizeAlias = json['sizeAlias'] != null
        ? SizeAliasModel.fromJson(json['sizeAlias'])
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
    data['quantity'] = quantity;
    if (sizeAlias != null) {
      data['sizeAlias'] = sizeAlias.toJson();
    }
    return data;
  }
}
