import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'stop_model.freezed.dart';
part 'stop_model.g.dart';

@freezed
abstract class StopModel implements _$StopModel {
  // ignore: unused_element
  const StopModel._();

  factory StopModel({
    int id,
    String key,
    RouteModel route,
    List<OrderModel> orders,
    List<StopDocumentModel> stopDocuments,
    LocationModel location,
    int plannedSequenceNum,
    StopTypeModel stopType,
    TransportModel transport,
    String actualArrival,
    String plannedArrival,
    String projectedArrival,
    String actualDeparture,
    String plannedDeparture,
    String projectedDeparture,
    @JsonKey(fromJson: convertToDouble) double plannedSize1,
    @JsonKey(fromJson: convertToDouble) double plannedSize2,
    @JsonKey(fromJson: convertToDouble) double plannedSize3,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize1,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize2,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize3,
    bool hasPicture,
    bool hasSignature,
    @JsonKey(fromJson: convertToDouble) double longitude,
    @JsonKey(fromJson: convertToDouble) double latitude,
    String ordersInfo,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size2AliasConfig,
    BaseUnitModel size3AliasConfig,
    bool returned,
    bool redelivered,
    bool canceled,
    @JsonKey(fromJson: convertToDouble) double damagedSize1,
    @JsonKey(fromJson: convertToDouble) double damagedSize2,
    @JsonKey(fromJson: convertToDouble) double damagedSize3,
  }) = _StopModel;

  factory StopModel.fromJson(Map<String, dynamic> json) =>
      _$StopModelFromJson(json);

  bool get isFinished => actualDeparture != null;

  bool get isCloned => key.contains('clone-');

  bool get hasBeenArrived => actualArrival != null;

  bool get hasNotBeenArrived => actualArrival == null;
}
