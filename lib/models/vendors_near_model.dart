// To parse this JSON data, do
//
//     final vendorsNearModel = vendorsNearModelFromJson(jsonString);

import 'dart:convert';

VendorsNearModel vendorsNearModelFromJson(String str) => VendorsNearModel.fromJson(json.decode(str));

String vendorsNearModelToJson(VendorsNearModel data) => json.encode(data.toJson());

class VendorsNearModel {
  int? id;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  double? distance;
  dynamic open;
  dynamic close;
  String? phone;
  String? email;
  String? address;
  String? latitude;
  String? longitude;
  String? isActive;
  bool? isOpen;
  String? vendorTypeId;
  DateTime? createdAt;
  String? type;
  dynamic test;
  DateTime? startDate;
  DateTime? expireDate;
  String? avgRating;
  String? logo;
  List<Feature>? features;

  VendorsNearModel({
    this.id,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.distance,
    this.open,
    this.close,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.isActive,
    this.isOpen,
    this.vendorTypeId,
    this.createdAt,
    this.type,
    this.test,
    this.startDate,
    this.expireDate,
    this.avgRating,
    this.logo,
    this.features,
  });

  factory VendorsNearModel.fromJson(Map<String, dynamic> json) => VendorsNearModel(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    description: json["description"],
    descriptionAr: json["description_ar"],
    distance: json["distance"].toDouble(),
    open: json["open"],
    close: json["close"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isActive: json["is_active"],
    isOpen: json["is_open"],
    vendorTypeId: json["vendor_type_id"],
    createdAt: DateTime.parse(json["created_at"]),
    type: json["type"],
    test: json["test"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
//    expireDate: DateTime.parse(json["expire_date"]),
    avgRating: json["avg_rating"],
    logo: json["logo"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "description": description,
    "description_ar": descriptionAr,
    "distance": distance,
    "open": open,
    "close": close,
    "phone": phone,
    "email": email,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "is_active": isActive,
    "is_open": isOpen,
    "vendor_type_id": vendorTypeId,
    "created_at": createdAt?.toIso8601String(),
    "type": type,
    "test": test,
    "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
    "expire_date": "${expireDate?.year.toString().padLeft(4, '0')}-${expireDate?.month.toString().padLeft(2, '0')}-${expireDate?.day.toString().padLeft(2, '0')}",
    "avg_rating": avgRating,
    "logo": logo,
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),
  };
  static List<VendorsNearModel> listFromJson(List<dynamic> json) {
    return json.map((value) => VendorsNearModel.fromJson(value)).toList();
  }
}

class Feature {
  String? name;
  String? content;

  Feature({
    this.name,
    this.content,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    name: json["name"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "content": content,
  };


}
