import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/sub_category_item_model.dart';

abstract class SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategoryError extends SubCategoryState {
  String error;
  SubCategoryError(this.error);
}

class SubCategorySuccess extends SubCategoryState {
  List<SubCategoryItemModel> subCategories;
  List<AdvertisementsResponse> mainAds;
  SubCategorySuccess(this.subCategories,this.mainAds);
}
