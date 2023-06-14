abstract class FavoritesListEvent {
  FavoritesListEvent([List props = const []]) : super();
}

class GetFavoritesList extends FavoritesListEvent {
  GetFavoritesList();
}
