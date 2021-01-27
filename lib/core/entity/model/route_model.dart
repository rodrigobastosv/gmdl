import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/enums.dart';
import '../serializing_utils.dart';
import 'models.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

@freezed
abstract class RouteModel with _$RouteModel {
  factory RouteModel({
    int id,
    OrganizationModel organization,
    String key,
    String date,
    String description,
    LocationModel origin,
    @JsonKey(fromJson: convertToDouble) double origLatitude,
    @JsonKey(fromJson: convertToDouble) double origLongitude,
    LocationModel destination,
    @JsonKey(fromJson: convertToDouble) double destLatitude,
    @JsonKey(fromJson: convertToDouble) double destLongitude,
    bool lastStopIsDestination,
    List<StopModel> stops,
    String plannedArrival,
    String plannedDeparture,
    String proactiveRouteOptApplied,
    @JsonKey(fromJson: convertToDouble) double plannedDistance,
    String plannedComplete,
    String plannedStart,
    List<LocationPendingPaymentModel> locationPendingPayments,
    List<AdditionalMaterialModel> additionalMaterials,
    List<HolderMaterialModel> holderMaterials,
    List<ManifestModel> manifests,
    int totalStops,
    @JsonKey(fromJson: statusFromJson, toJson: statusToJson) RouteStatus status,
    int plannedServiceTime,
    bool hasPicture,
    @JsonKey(fromJson: convertToDouble) double plannedSize1,
    @JsonKey(fromJson: convertToDouble) double plannedSize2,
    @JsonKey(fromJson: convertToDouble) double plannedSize3,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize1,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize2,
    @JsonKey(fromJson: convertToDouble) double plannedPickupSize3,
    BaseUnitModel size1AliasConfig,
    BaseUnitModel size3AliasConfig,
    ProactiveRouteOptConfigModel proactiveRouteOptConfig,
    bool onRoute,
  }) = _RouteModel;

  @late
  bool get isUsingPro => proactiveRouteOptConfig != null;

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
}
