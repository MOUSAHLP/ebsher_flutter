
class ExhibitionsModel {
  int? id;
  String? name;
  String? start_date;
  String? end_date;
  String? Organizing_company;
  String? Visit_times;
  String? place;
  String? image;


  ExhibitionsModel({
    this.id,
    this.name,
    this.start_date,
    this.end_date,
    this.Organizing_company,
    this.Visit_times,
    this.place,
    this.image,

  });

  factory ExhibitionsModel.fromJson(Map<String, dynamic> json) => ExhibitionsModel(
    id: json["id"],
    name:  json["name"],
    start_date:  json["start_date"],
    end_date:  json["end_date"],
    Organizing_company:  json["Organizing_company"],
    Visit_times:  json["Visit_times"],
    place:  json["place"],
    image: json["image"],

  );

  static List<ExhibitionsModel> listFromJson( List<dynamic> json){
    return json.map((value) =>ExhibitionsModel.fromJson(value) ).toList();
  }
}