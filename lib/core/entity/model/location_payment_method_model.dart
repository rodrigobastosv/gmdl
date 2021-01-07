import 'models.dart';

class LocationPaymentMethodModel {
  int id;
  PaymentMethodModel paymentMethod;

  LocationPaymentMethodModel({
    this.id,
    this.paymentMethod,
  });

  LocationPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['paymentMethod'] != null
        ? PaymentMethodModel.fromJson(json['paymentMethod'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (paymentMethod != null) {
      data['paymentMethod'] = paymentMethod.toJson();
    }
    return data;
  }
}
