class SearchParams {
  String? textSearch;
  SearchParams({this.textSearch});
  Map<String, dynamic> toJson() => {
    "textSearch": textSearch,
  };
}