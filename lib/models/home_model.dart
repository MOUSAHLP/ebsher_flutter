import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/story_model.dart';

import 'category_response.dart';

class HomeModel {
  List<CategoyResponse>? categories;
  List<AdvertisementsResponse>? mainAds;
  List<StoryModelDto>? story;
  HomeModel({
    this.story,
    this.mainAds,
    this.categories,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        story: List<StoryModelDto>.from(
            json["stories"].map((x) => StoryModelDto.fromJson(x))),
        mainAds: List<AdvertisementsResponse>.from(
            json["mainAds"].map((x) => AdvertisementsResponse.fromJson(x))),
        categories: List<CategoyResponse>.from(
            json["categories"].map((x) => CategoyResponse.fromJson(x))),
      );
}
