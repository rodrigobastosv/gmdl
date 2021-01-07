import '../serializing_utils.dart';
import 'models.dart';

class LocationPendingPaymentModel {
  int id;
  LocationModel location;
  double amount;
  String saleDate;
  String dueDate;
  String remark;
  String documentKey;
  String invoice;

  LocationPendingPaymentModel({
    this.id,
    this.location,
    this.amount,
    this.saleDate,
    this.dueDate,
    this.remark,
    this.documentKey,
    this.invoice,
  });

  LocationPendingPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    amount = convertToDouble(json['amount']);
    saleDate = json['saleDate'];
    dueDate = json['dueDate'];
    remark = json['remark'];
    documentKey = json['documentKey'];
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (location != null) {
      data['location'] = location.toJson();
    }
    data['amount'] = amount;
    data['saleDate'] = saleDate;
    data['dueDate'] = dueDate;
    data['remark'] = remark;
    data['documentKey'] = documentKey;
    data['invoice'] = invoice;
    return data;
  }
}
