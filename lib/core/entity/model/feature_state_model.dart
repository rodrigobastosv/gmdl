import 'models.dart';

class FeatureStateModel {
  String name;
  bool enabled;
  ParameterModel parameters;

  FeatureStateModel({
    this.name,
    this.enabled,
    this.parameters,
  });

  FeatureStateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enabled = json['enabled'];
    parameters = json['parameters'] != null
        ? ParameterModel.fromJson(json['parameters'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['enabled'] = enabled;
    if (parameters != null) {
      data['parameters'] = parameters.toJson();
    }
    return data;
  }
}
