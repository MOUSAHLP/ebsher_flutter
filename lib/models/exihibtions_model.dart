import 'localization_String_model.dart';

class ExhibitionsModel {
  int? id;
  String? name;
  String? image;


  ExhibitionsModel({
    this.id,
    this.name,
    this.image,

  });

  factory ExhibitionsModel.fromJson(Map<String, dynamic> json) => ExhibitionsModel(
    id: json["id"],
    name:  json["name"],
    image: json["image"],

  );

  static List<ExhibitionsModel> listFromJson( List<dynamic> json){
    return json.map((value) =>ExhibitionsModel.fromJson(value) ).toList();
  }
}