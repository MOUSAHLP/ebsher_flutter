abstract class FavoritesListEvent {
  FavoritesListEvent([List props = const []]) : super();
}

class GetFavoritesList extends FavoritesListEvent {
  GetFavoritesList();
}

class AddFavorite extends FavoritesListEvent{
  int idVendor;
  AddFavorite(this.idVendor);
}
class RemoveFavorite extends FavoritesListEvent{
  int idVendor;
  RemoveFavorite(this.idVendor);
}
class ChangeFavoriteStatusRestaurant extends FavoritesListEvent {
  final int id;
  ChangeFavoriteStatusRestaurant(
      this.id

      );
}