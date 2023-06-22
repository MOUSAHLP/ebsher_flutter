import 'package:absher/bloc/search_bloc/search_event.dart';
import 'package:absher/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/favorite_repository.dart';
import '../../data/repos/home_repository.dart';
import '../../models/vendor_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<VendorModel> vendorsList = [];

  SearchBloc() : super(SearchCategoryLoading()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchCategory) {
        emit(SearchCategoryLoading());
        vendorsList.clear();
        final response =
            await HomeRepository.getSearchCategory(text: event.textSearch);
        response.fold((l) {
          emit(SearchCategoryError(l));
        }, (r) {
          vendorsList = [...r];
          emit(SearchCategorySuccess(vendorsList));
        });
      }

      if (event is ChangeFavoriteStatus) {
        int targetedIndex =
            vendorsList.indexWhere((element) => element.id == event.vendorId);
        if (vendorsList[targetedIndex].favoriteStatus) {
          vendorsList[targetedIndex].favoriteStatus = false;
          emit(SearchCategorySuccess(vendorsList));
          final response =
              await FavoriteRepository.removeFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = true;
            emit(SearchCategorySuccess(vendorsList));
          }, (r) {});
        } else {
          vendorsList[targetedIndex].favoriteStatus = true;
          emit(SearchCategorySuccess(vendorsList));
          final response = await FavoriteRepository.addFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = false;
            emit(SearchCategorySuccess(vendorsList));
          }, (r) {});
        }
      }
    });
  }
}
