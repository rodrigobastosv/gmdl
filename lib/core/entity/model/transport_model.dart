import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_model.freezed.dart';
part 'transport_model.g.dart';

@freezed
abstract class TransportModel with _$TransportModel {
  factory TransportModel({
    int id,
    String key,
    String date,
    String alternativeKey,
  }) = _TransportModel;

  factory TransportModel.fromJson(Map<String, dynamic> json) =>
      _$TransportModelFromJson(json);
}
