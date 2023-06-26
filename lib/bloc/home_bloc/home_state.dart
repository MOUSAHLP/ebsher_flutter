import 'package:absher/models/story_model.dart';

import '../../models/advertisement_response.dart';
import '../../models/category_response.dart';

abstract class HomeState {}

class CategoryLoading extends HomeState {}

class CategoryError extends HomeState {
  String error;
  CategoryError(this.error);
}

class CategorySuccess extends HomeState {
  int index;
  List<CategoyResponse> listCategory;
  List<AdvertisementsResponse> listAdvertisments;
  List<StoryModelDto> listStories;
  CategorySuccess(this.index, this.listCategory, this.listAdvertisments,this.listStories);
}
class ChangeSeeStorySuccess extends HomeState{}
