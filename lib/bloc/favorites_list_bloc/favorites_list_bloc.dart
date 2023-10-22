import 'package:absher/bloc/favorites_list_bloc/favorites_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/favorite_repository.dart';
import '../../models/vendor_model.dart';
import 'favorites_list_state.dart';

class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  List<int> favoritesIds = [];
  List<VendorModel> favoriteListRestaurant = [];
  List<int> idRestaurant=[];
  bool isFavoriteRestaurant(int id){
    bool x=false;
    if (idRestaurant.any((element) => element == id))
    {
      x =true;
      return x;
    }
    return x;
  }
  FavoritesListBloc() : super(FavoritesListLoading()) {
    on<FavoritesListEvent>((event, emit) async {
      if (event is GetFavoritesList) {
        emit(FavoritesListLoading());
        final response = await FavoriteRepository.getFavoriteList();
        response.fold((l) {
          emit(FavoritesListError(l));
        }, (r) {
          favoriteListRestaurant=r;
          emit(FavoritesListSuccess(r));
        });
      }
      if (event is AddFavorite) {
        final response = await FavoriteRepository.addFavorite(event.idVendor);
        response.fold((l) {
          emit(FavoritesListError(l));
        }, (r) {
          // add(GetFavoritesList());
          emit(AddFavoriteSuccess());
        });
      }
      if (event is RemoveFavorite) {
        final response =
            await FavoriteRepository.removeFavorite(event.idVendor);
        response.fold((l) {
          emit(FavoritesListError(l));
        }, (r) {
          // add(GetFavoritesList());
          emit(RemoveFavoriteSuccess());
        });
      }
      if (event is ChangeFavoriteStatusRestaurant) {
        if (!isFavoriteRestaurant(event.id)) {
          idRestaurant.add(event.id);
          emit(RemoveFavoriteSuccess());
          final response =
          await FavoriteRepository.addFavorite(event.id);
          response.fold((l) {
            idRestaurant
                .removeWhere((element) => element== event.id);
            emit(RemoveFavoriteSuccess());
          }, (r) {
            emit(RemoveFavoriteSuccess());
          });
        }
        else {
          idRestaurant
              .removeWhere((element) => element == event.id);
          emit(RemoveFavoriteSuccess());
          final response = await FavoriteRepository.removeFavorite(event.id);
          response.fold((l) {
            idRestaurant.add(event.id);
            emit(RemoveFavoriteSuccess());
          }, (r) {

            emit(RemoveFavoriteSuccess());
          });
        }
      }
    });
  }
}
