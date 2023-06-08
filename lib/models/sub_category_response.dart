

import 'dart:convert';

SubCategoryResponse subCategoryResponseFromJson(String str) => SubCategoryResponse.fromJson(json.decode(str));

String subCategoryResponseToJson(SubCategoryResponse data) => json.encode(data.toJson());

class SubCategoryResponse {
  int? id;
  String? name;

  SubCategoryResponse({
    this.id,
    this.name,
  });

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) => SubCategoryResponse(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
  static List<SubCategoryResponse> listFromJson( List<dynamic> json){
    return json.map((value) =>SubCategoryResponse.fromJson(value) ).toList();
  }
}
