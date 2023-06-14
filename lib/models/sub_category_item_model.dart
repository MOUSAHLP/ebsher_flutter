import 'localization_String_model.dart';

class SubCategoryItemModel {
  int? id;
  localizationStringModel? name;
  String? image;
  String? thumbnail;
  String? categoryId;

  SubCategoryItemModel({
    this.id,
    this.name,
    this.image,
    this.thumbnail,
    this.categoryId,
  });

  factory SubCategoryItemModel.fromJson(Map<String, dynamic> json) => SubCategoryItemModel(
    id: json["id"],
    name: localizationStringModel.fromJson(json, "name"),
    image: json["image"],
    thumbnail: json["thumbnail"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "thumbnail": thumbnail,
    "category_id": categoryId,
  };
}