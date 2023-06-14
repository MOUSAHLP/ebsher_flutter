import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/story_model.dart';
import 'package:absher/models/sub_category_item_model.dart';

import 'category_response.dart';

class SubCategoriesModel {
  List<SubCategoryItemModel>? subCategories;
  List<AdvertisementsResponse>? mainAds;
  SubCategoriesModel({
    this.mainAds,
    this.subCategories,
  });

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) => SubCategoriesModel(
    mainAds: List<AdvertisementsResponse>.from(json["ads"].map((x) => AdvertisementsResponse.fromJson(x))),
    subCategories: List<SubCategoryItemModel>.from(json["subcategoris"].map((x) => SubCategoryItemModel.fromJson(x))),
  );
}