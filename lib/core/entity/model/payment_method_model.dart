class PaymentMethodModel {
  int id;

  PaymentMethodModel({this.id});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
