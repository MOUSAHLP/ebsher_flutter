import 'dart:convert';

class localizationStringModel{
  String? value;
  String? valueAr;

  factory localizationStringModel.fromJson(Map<String, dynamic> json,key) {
    return localizationStringModel(
      value: json[key],
      valueAr: json["${key}_ar"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "value": this.value,
      "valueAr": this.valueAr,
    };
  }

  localizationStringModel(  {required this.value, required this.valueAr} );
}

