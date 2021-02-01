import 'package:freezed_annotation/freezed_annotation.dart';

import '../serializing_utils.dart';
import 'models.dart';

part 'stop_model.freezed.dart';
part 'stop_model.g.dart';

@freezed
abstract class StopModel implements _$StopModel {
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
    String cloneDate,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size2AliasConfig,
    BaseUnitModel size3AliasConfig,
    bool returned,
    bool redelivered,
    bool canceled,
    CancelCodeModel cancelCode,
    UndeliverableCodeModel undeliverableCode,
    StopModel redeliveryStop,
    @JsonKey(fromJson: convertToDouble) double damagedSize1,
    @JsonKey(fromJson: convertToDouble) double damagedSize2,
    @JsonKey(fromJson: convertToDouble) double damagedSize3,
  }) = _StopModel;

  @late
  bool get stopHadActionPerformed =>
      isCloned || isCanceled || isRedelivered || isUndeliverable;

  @late
  bool get canClone =>
      (!isCloned && (isFinished || isCanceled || isUndeliverable)) ||
      (isCloned && isDone);

  @late
  bool get isInProgress => hasBeenArrived && hasNotBeenDeparted;

  @late
  bool get isPending => hasNotBeenDeparted && !isCanceled;

  @late
  bool get isDone => !isPending;

  @late
  bool get isFinished => actualDeparture != null;

  @late
  bool get isCloned => cloneDate != null;

  @late
  bool get isCanceled => cancelCode != null;

  @late
  bool get isUndeliverable => undeliverableCode != null;

  @late
  bool get isRedelivered => isUndeliverable && redeliveryStop != null;

  @late
  bool get hasBeenArrived => actualArrival != null;

  @late
  bool get hasNotBeenArrived => actualArrival == null;

  @late
  bool get hasNotBeenDeparted => actualDeparture == null;

  factory StopModel.fromJson(Map<String, dynamic> json) =>
      _$StopModelFromJson(json);
}
