import '../../models/search_response.dart';

abstract class SearchState {}
class SearchCategoryLoading extends SearchState{}
class SearchCategorySuccess extends SearchState{
  List<SearchResponse> listSearch;
  SearchCategorySuccess(this.listSearch);
}
class SearchCategoryError extends SearchState{
  String error;
  SearchCategoryError(this.error);
}