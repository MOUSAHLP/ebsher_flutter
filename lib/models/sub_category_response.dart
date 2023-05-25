// To parse this JSON data, do
//
//     final subCategoryResponse = subCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'localization_String_model.dart';

SubCategoriesResponse subCategoryResponseFromJson(String str) => SubCategoriesResponse.fromJson(json.decode(str));

String subCategoryResponseToJson(SubCategoriesResponse data) => json.encode(data.toJson());

class SubCategoriesResponse {
  int? id;
  localizationStringModel? name;
  localizationStringModel? description;
  dynamic? distance;
  String? open;
  String? close;
  String? phone;
  String? email;
  String? address;
  String? latitude;
  String? longitude;
  String? isActive;
  bool? isOpen;
  String? vendorTypeId;
  DateTime? createdAt;
  String? test;
  DateTime? startDate;
  DateTime? expireDate;
  String? avgRating;
  String? logo;
  List<Feature>? features;
  VendorType? vendorType;

  SubCategoriesResponse({
    this.id,
    this.name,

    this.description,

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
    this.test,
    this.startDate,
    this.expireDate,
    this.avgRating,
    this.logo,
    this.features,
    this.vendorType,
  });

  factory SubCategoriesResponse.fromJson(Map<String, dynamic> json) {
    print("========from");
    return SubCategoriesResponse(
    id: json["id"],
    name: localizationStringModel.fromJson(json,"name"),
    description:  localizationStringModel.fromJson(json,"description"),
    distance: json["distance"],
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
    test: json["test"],
    startDate:json["start_date"]==null?null: DateTime.parse(json["start_date"]),
    expireDate:json["expire_date"]==null?null: DateTime.parse(json["expire_date"]),
    avgRating: json["avg_rating"],
    logo: json["logo"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    vendorType: VendorType.fromJson(json["vendor_type"]),
  );}

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,

    "description": description,

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
    "test": test,
    "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
    "expire_date": "${expireDate!.year.toString().padLeft(4, '0')}-${expireDate?.month.toString().padLeft(2, '0')}-${expireDate?.day.toString().padLeft(2, '0')}",
    "avg_rating": avgRating,
    "logo": logo,
    "features": List<dynamic>.from(features!.map((x) => x.toJson())),

    "vendor_type": vendorType?.toJson(),
  };
  static List<SubCategoriesResponse> listFromJson(Map<String, dynamic> json) {
    return json["data"].map<SubCategoriesResponse>((value) => SubCategoriesResponse.fromJson(value)).toList();
  }
}
class Feature {
  String? content;
  String? name;

  Feature({
    this.content,
    this.name,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    content: json["content"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "name": name,
  };
}


class VendorType {
  int? id;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? isActive;
  String? image;
  String? logo;

  VendorType({
    this.id,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.isActive,
    this.image,
    this.logo,
  });

  factory VendorType.fromJson(Map<String, dynamic> json) => VendorType(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    description: json["description"],
    descriptionAr: json["description_ar"],
    isActive: json["is_active"],
    image: json["image"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "description": description,
    "description_ar": descriptionAr,
    "is_active": isActive,
    "image": image,
    "logo": logo,
  };
}
