import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'location_payment_method_model.freezed.dart';
part 'location_payment_method_model.g.dart';

@freezed
abstract class LocationPaymentMethodModel with _$LocationPaymentMethodModel {
  factory LocationPaymentMethodModel({
    int id,
    PaymentMethodModel paymentMethod,
  }) = _LocationPaymentMethodModel;

  factory LocationPaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$LocationPaymentMethodModelFromJson(json);
}
