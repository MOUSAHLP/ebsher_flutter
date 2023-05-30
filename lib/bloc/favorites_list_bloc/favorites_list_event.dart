abstract class FavoritesListEvent {
  FavoritesListEvent([List props = const []]) : super();
}

class GetFavoritesList extends FavoritesListEvent {
  final int idCategory;

  GetFavoritesList(this.idCategory);
}
