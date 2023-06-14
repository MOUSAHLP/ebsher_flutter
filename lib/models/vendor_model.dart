// To parse this JSON data, do
//
//     final subCategoryResponse = subCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:absher/models/vendors_near_model.dart';

import 'localization_String_model.dart';

class VendorModel {
  int? id;
  localizationStringModel? name;
  localizationStringModel? description;
 String? image;
  String? open;
  String? close;
  String? phone;
  String? email;
  String? address;
  String? address2;
  String? latitude;
  String? longitude;
  String? isActive;
  String? isOpen;
  DateTime? createdAt;
  DateTime? startDate;
  DateTime? expireDate;
  String? avgRating;

  String ? categoryId;
  dynamic? packageId;
  String? visits;
  DateTime? customDate;
  dynamic? webiste;
  DateTime? updatedAt;
  int? openStatus;
  int? favoriteStatus;
  Category? category;
  VendorModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.open,
    this.close,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.isActive,
    this.isOpen,
    this.createdAt,
    this.startDate,
    this.expireDate,
    this.avgRating,
    this.categoryId,
    this.packageId,
    this.visits,
    this.customDate,
    this.webiste,
    this.updatedAt,
    this.openStatus,
    this.favoriteStatus,
    this.category,
    this.address2
  });



  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json["id"],
      name: localizationStringModel.fromJson(json, "name"),
      description: localizationStringModel.fromJson(json, "description"),
      open: json["open"],
      image: json["image"],
      close: json["close"],
      phone: json["phone"],
      email: json["email"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isActive: json["is_active"],
      isOpen: json["is_open"],
      createdAt: DateTime.parse(json["created_at"]),
      startDate: json["start_date"] == null
          ? null
          : DateTime.parse(json["start_date"]),
      expireDate: json["expire_date"] == null
          ? null
          : DateTime.parse(json["expire_date"]),
      avgRating: json["avg_rating"],
      categoryId: json["category_id"],
      packageId: json["package_id"],
      visits: json["visits"],
      customDate:json["custom_date"]==null?null: DateTime.parse(json["custom_date"]),
      webiste: json["webiste"],
      updatedAt:json["updated_at"]==null?null: DateTime.parse(json["updated_at"]),
      openStatus: json["open_status"],
      favoriteStatus: json["favorite_status"],
      category: json["category"]==null?null:Category.fromJson(json["category"]),
    );
  }
  static List<VendorModel> listFromJson(Map<String, dynamic> json) {

    return json["data"]
        .map<VendorModel>((value) => VendorModel.fromJson(value))
        .toList();
  }
}
class Category {
  int? id;
  localizationStringModel? name;
  localizationStringModel? description;
  String? isActive;
  String? image;
  String? thumbnail;
  String? color;
  String? featured;
  dynamic createdAt;
  dynamic updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.image,
    this.thumbnail,
    this.color,
    this.featured,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: localizationStringModel.fromJson(json, "name"),
    description: localizationStringModel.fromJson(json, "description"),
    isActive: json["is_active"],
    image: json["image"],
    thumbnail: json["thumbnail"],
    color: json["color"],
    featured: json["featured"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "is_active": isActive,
    "image": image,
    "thumbnail": thumbnail,
    "color": color,
    "featured": featured,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

