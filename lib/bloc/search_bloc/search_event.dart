abstract class SearchEvent {
  SearchEvent([List props = const []]) : super();
}

class SearchCategory extends SearchEvent {


  SearchCategory(
      );
}
class SearchCategoryPage extends SearchEvent {
  SearchCategoryPage(
      );
}

class ChangeFavoriteStatus extends SearchEvent {
  final int vendorId;

  ChangeFavoriteStatus(
    this.vendorId,
  );
}
class Clear extends SearchEvent {
  final String vendorId;

  Clear(
      this.vendorId,
      );
}
