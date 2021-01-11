import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'location_pending_payment_model.freezed.dart';
part 'location_pending_payment_model.g.dart';

@freezed
abstract class LocationPendingPaymentModel with _$LocationPendingPaymentModel {
  factory LocationPendingPaymentModel({
    int id,
    LocationModel location,
    double amount,
    String saleDate,
    String dueDate,
    String remark,
    String documentKey,
    String invoice,
  }) = _LocationPendingPaymentModel;

  factory LocationPendingPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$LocationPendingPaymentModelFromJson(json);
}
