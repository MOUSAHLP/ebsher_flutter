
class CityNameModel {
  final List<Datum> data;

  CityNameModel({
    required this.data,
  });



  factory CityNameModel.fromJson(Map<String, dynamic> json) => CityNameModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
   final int id;
    int ? cityId;
   final String name;
   int ?stateId;
   dynamic createdAt;
   dynamic  updatedAt;

  Datum({
     required this.id,
     required this.name,
     this.stateId,
     this.cityId,
     this.createdAt,
     this.updatedAt,
  });


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    cityId: json["city_id"],
    name: json["name"],
    stateId: json["state_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );


}
