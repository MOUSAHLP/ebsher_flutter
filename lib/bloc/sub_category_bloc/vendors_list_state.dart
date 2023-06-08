import '../../models/sub_category_response.dart';

abstract class SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategoryError extends SubCategoryState {
  String error;
  SubCategoryError(this.error);
}

class SubCategorySuccess extends SubCategoryState {
  List<SubCategoryResponse> vendorsList;
  SubCategorySuccess(this.vendorsList);
}
