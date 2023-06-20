import '../../models/vendor_model.dart';

abstract class FavoritesListState {}

class FavoritesListLoading extends FavoritesListState {}

class FavoritesListError extends FavoritesListState {
  String error;
  FavoritesListError(this.error);
}

class FavoritesListSuccess extends FavoritesListState {
  List<VendorModel> vendorsList;
  FavoritesListSuccess(this.vendorsList);
}
class AddFavoriteSuccess extends FavoritesListState{}
class RemoveFavoriteSuccess extends FavoritesListState{}