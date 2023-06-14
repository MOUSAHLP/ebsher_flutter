import 'package:absher/models/story_model.dart';

import '../../models/advertisement_response.dart';
import '../../models/category_response.dart';
import '../../models/search_response.dart';

abstract class HomeState {}

class CategoryLoading extends HomeState {}

class CategoryError extends HomeState {
  String error;
  CategoryError(this.error);
}

class CategorySuccess extends HomeState {
  int index;
  List<CategoyResponse> lisCategory;
  List<AdvertisementsResponse> lisAdvertisment;
  List<StoryModelDto> listStories;
  CategorySuccess(this.index, this.lisCategory, this.lisAdvertisment,this.listStories);
}
