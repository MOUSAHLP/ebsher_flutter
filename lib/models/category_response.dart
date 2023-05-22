// To parse this JSON data, do
//
//     final categoyResponse = categoyResponseFromJson(jsonString);

import 'dart:convert';

import 'localization_String_model.dart';

CategoyResponse categoyResponseFromJson(String str) => CategoyResponse.fromJson(json.decode(str));

String categoyResponseToJson(CategoyResponse data) => json.encode(data.toJson());

class CategoyResponse {
  int? id;
  localizationStringModel? name;
  localizationStringModel? description;
  String? logo;
  CategoyResponse({
    this.id,
    this.name,
    this.description,
    this.logo,
  });
  factory CategoyResponse.fromJson(Map<String, dynamic> json)  {
    return
    CategoyResponse(
    id: json["id"],
    name: localizationStringModel.fromJson(json,"name"),
    description:localizationStringModel.fromJson(json,"description"),
    logo: json["logo"],
  );}

  Map<String, dynamic> toJson() => {
    "id": id,
    "name":name,
    "description": description,
    "logo": logo,
  };
  static List<CategoyResponse> listFromJson( List<dynamic> json){
    return json.map((value) =>CategoyResponse.fromJson(value) ).toList();
  }
}
