// To parse this JSON data, do
//
//     final categoyResponse = categoyResponseFromJson(jsonString);

import 'dart:convert';

import 'localization_String_model.dart';

CategoyResponse categoyResponseFromJson(String str) => CategoyResponse.fromJson(json.decode(str));

String categoyResponseToJson(CategoyResponse data) => json.encode(data.toJson());

class CategoyResponse {
  int? id;
  LocalizationStringModel? name;
  LocalizationStringModel? description;
  int? isActive;
  String? image;
  String? thumbnail;
  String? color;
  int? featured;
  String? vendorsCount;
  dynamic createdAt;
  dynamic updatedAt;
  CategoyResponse({
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
    this.vendorsCount

  });
  factory CategoyResponse.fromJson(Map<String, dynamic> json)  {
    return
    CategoyResponse(
    id: json["id"],
    name: LocalizationStringModel.fromJson(json,"name"),
    description:LocalizationStringModel.fromJson(json,"description"),
      isActive: json["is_active"],
      image: json["image"],
      thumbnail: json["thumbnail"],
      color: json["color"]??"",
      featured: json["featured"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      vendorsCount: json["vendors_count"],
  );}

  Map<String, dynamic> toJson() => {
    "id": id,
    "name":name,
    "description": description,
    "is_active": isActive,
    "image": image,
    "thumbnail": thumbnail,
    "color": color,
    "featured": featured,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "vendors_count": vendorsCount,
  };
  static List<CategoyResponse> listFromJson( List<dynamic> json){
    return json.map((value) =>CategoyResponse.fromJson(value) ).toList();
  }
}
