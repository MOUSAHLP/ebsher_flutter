import '../../models/sub_category_response.dart';

abstract class SubCategoriesState {}

class SubCategoriesLoading extends SubCategoriesState {}

class SubCategoriesError extends SubCategoriesState {
  String error;
  SubCategoriesError(this.error);
}
class SubCategoriesSuccess extends SubCategoriesState
{
  List<SubCategoriesResponse> lisSubCategory;
  SubCategoriesSuccess(this.lisSubCategory);
}
