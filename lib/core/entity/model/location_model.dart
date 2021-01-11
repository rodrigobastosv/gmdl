import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
abstract class LocationModel with _$LocationModel {
  factory LocationModel({
    int id,
    String key,
    LocationTypeModel locationType,
    String description,
    String taxID,
    String addressLine1,
    String addressLine2,
    String city,
    String state,
    String country,
    double longitude,
    double latitude,
    int deliveryRadius,
    double creditLimit,
    String legalName,
    String taxType,
    int appliedTax,
    List<PaymentMethodModel> locationPaymentMethods,
    String alternativeKey,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
