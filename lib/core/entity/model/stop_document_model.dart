import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop_document_model.freezed.dart';
part 'stop_document_model.g.dart';

@freezed
abstract class StopDocumentModel with _$StopDocumentModel {
  factory StopDocumentModel({
    int id,
    String documentDescription,
    String documentNumber,
  }) = _StopDocumentModel;

  factory StopDocumentModel.fromJson(Map<String, dynamic> json) =>
      _$StopDocumentModelFromJson(json);
}
