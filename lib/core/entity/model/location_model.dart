import 'location_type_model.dart';
import 'payment_method_model.dart';

class LocationModel {
  int id;
  String key;
  LocationTypeModel locationType;
  String description;
  String taxID;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  double longitude;
  double latitude;
  int deliveryRadius;
  double creditLimit;
  String legalName;
  String taxType;
  int appliedTax;
  List<PaymentMethodModel> locationPaymentMethods;
  String alternativeKey;

  LocationModel({
    this.id,
    this.key,
    this.locationType,
    this.description,
    this.taxID,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.longitude,
    this.latitude,
    this.deliveryRadius,
    this.creditLimit,
    this.legalName,
    this.taxType,
    this.appliedTax,
    this.locationPaymentMethods,
    this.alternativeKey,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    locationType = json['locationType'] != null
        ? LocationTypeModel.fromJson(json['locationType'])
        : null;
    description = json['description'];
    taxID = json['taxID'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    deliveryRadius = json['deliveryRadius'];
    creditLimit = json['creditLimit'];
    legalName = json['legalName'];
    taxType = json['taxType'];
    appliedTax = json['appliedTax'];
    if (json['locationPaymentMethods'] != null) {
      locationPaymentMethods = <PaymentMethodModel>[];
      json['locationPaymentMethods'].forEach((v) {
        locationPaymentMethods.add(PaymentMethodModel.fromJson(v));
      });
    }
    alternativeKey = json['alternativeKey'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    if (locationType != null) {
      data['locationType'] = locationType.toJson();
    }
    data['description'] = description;
    data['taxID'] = taxID;
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['deliveryRadius'] = deliveryRadius;
    data['creditLimit'] = creditLimit;
    data['legalName'] = legalName;
    data['taxType'] = taxType;
    data['appliedTax'] = appliedTax;
    if (locationPaymentMethods != null) {
      data['locationPaymentMethods'] =
          locationPaymentMethods.map((v) => v.toJson()).toList();
    }
    data['alternativeKey'] = alternativeKey;
    return data;
  }
}
