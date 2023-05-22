abstract class SearchEvent {
  SearchEvent([List props = const []]) : super();
}

class SearchCategory extends SearchEvent{
  final String  textSearch;
  SearchCategory(this.textSearch);
}