// To parse this JSON data, do
//
//     final categoyResponse = categoyResponseFromJson(jsonString);

import 'dart:convert';

CategoyResponse categoyResponseFromJson(String str) => CategoyResponse.fromJson(json.decode(str));

String categoyResponseToJson(CategoyResponse data) => json.encode(data.toJson());

class CategoyResponse {
  int? id;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? logo;
  CategoyResponse({
    this.id,
    this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    this.logo,
  });
  factory CategoyResponse.fromJson(Map<String, dynamic> json) => CategoyResponse(
    id: json["id"],
    name: json["name"],
    nameAr: json["name_ar"],
    description: json["description"],
    descriptionAr: json["description_ar"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": nameAr,
    "description": description,
    "description_ar": descriptionAr,
    "logo": logo,
  };
  static List<CategoyResponse> listFromJson( List<dynamic> json){
    return json.map((value) =>CategoyResponse.fromJson(value) ).toList();
  }
}
