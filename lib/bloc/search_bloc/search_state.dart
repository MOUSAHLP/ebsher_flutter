


import '../../models/vendor_model.dart';

abstract class SearchState {}
class SearchCategoryLoading extends SearchState{}
class SearchCategorySuccess extends SearchState{
  List<VendorModel> listSearch;
  SearchCategorySuccess(this.listSearch);
}
class SearchCategoryError extends SearchState{
  String error;
  SearchCategoryError(this.error);
}