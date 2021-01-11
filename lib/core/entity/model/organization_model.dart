import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
abstract class OrganizationModel with _$OrganizationModel {
  factory OrganizationModel({
    int id,
    String creationDate,
    String key,
    OrganizationModel parentOrganization,
    String description,
    PreferedLocaleModel preferedLocale,
    TimeZoneModel timeZone,
    String unitSystem,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);
}
