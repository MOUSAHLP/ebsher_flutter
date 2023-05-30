

import 'package:absher/bloc/favorites_list_bloc/favorites_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repository.dart';
import 'favorites_list_state.dart';

class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  FavoritesListBloc() : super( FavoritesListLoading()) {
    on<FavoritesListEvent>((event, emit) async {
      if (event is  GetFavoritesList) {
        emit(FavoritesListLoading());
        final response =
            await HomeRepository.getVendorsList(categoryId: event.idCategory);
        response.fold((l) {
          emit(FavoritesListError(l));
        }, (r) {
          emit(FavoritesListSuccess(r));
        });
      }
    });
  }
}
