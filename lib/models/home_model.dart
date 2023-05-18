import 'package:absher/models/advertisement_response.dart';

import 'category_response.dart';

class HomeModel {
  List<CategoyResponse>? categories;
  List<AdvertisementsResponse>? mainAds;

  HomeModel({
    this.categories,
    this.mainAds,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    categories: List<CategoyResponse>.from(json["categories"].map((x) => CategoyResponse.fromJson(x))),
    mainAds: List<AdvertisementsResponse>.from(json["mainAds"].map((x) => AdvertisementsResponse.fromJson(x))),
  );
}