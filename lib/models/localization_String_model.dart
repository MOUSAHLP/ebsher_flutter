


 class LocalizationStringModel{
  String? value;
  String? valueAr;

  factory LocalizationStringModel.fromJson(Map<String, dynamic> json,key) {
    return LocalizationStringModel(
      value: json[key],
      valueAr: json["${key}_ar"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "value": value,
      "valueAr": valueAr,
    };
  }

  LocalizationStringModel(  {required this.value, required this.valueAr} );
}

