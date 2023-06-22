import 'package:absher/bloc/favorites_list_bloc/favorites_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/favorite_repository.dart';
import '../../data/repos/home_repository.dart';
import 'favorites_list_state.dart';

class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  List<int> favoritesIds = [];

  FavoritesListBloc() : super(FavoritesListLoading()) {
    on<FavoritesListEvent>((event, emit) async {
      if (event is GetFavoritesList) {
        emit(FavoritesListLoading());
        final response = await FavoriteRepository.getFavoriteList();
        response.fold((l) {
          emit(FavoritesListError(l));
        }, (r) {
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
    });
  }

  bool idIsInFavorite(int id) {
    if (favoritesIds.any((element) => element == id)) {
      return true;
    } else {
      return false;
    }
  }
}
