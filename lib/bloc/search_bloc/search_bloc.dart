import 'package:absher/bloc/search_bloc/search_event.dart';
import 'package:absher/bloc/search_bloc/search_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/favorite_repository.dart';
import '../../data/repos/home_repository.dart';
import '../../models/params/search_params.dart';
import '../../models/vendor_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<VendorModel> vendorsList = [];
  GetSearchParams pendingFilter = GetSearchParams();
  int maxCount = 10;
  bool isFirstLoading = true;
  bool isLast = false;
  TextEditingController searchController = TextEditingController();
  SearchBloc() : super(SearchState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchCategory) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        isFirstLoading = true;
        pendingFilter.skipCount = 0;
        pendingFilter.maxCount = maxCount;
        pendingFilter.textSearch = searchController.text;
        vendorsList.clear();
        final response =
            await HomeRepository.getSearchCategory(text: pendingFilter);
        response.fold((l) {
          if (l != 'Cancel') {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }
        }, (r) {
          isFirstLoading = false;
          vendorsList.addAll(r);
          emit(state.copyWith(
              screenStates: ScreenStates.success, vendorsList: vendorsList));
        });
      }
      if (event is SearchCategoryPage) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        pendingFilter.skipCount = vendorsList.length;
        pendingFilter.maxCount = maxCount;
        pendingFilter.textSearch = searchController.text;
        final response =
            await HomeRepository.getSearchCategory(text: pendingFilter);
        response.fold((l) {
          emit(state.copyWith(screenStates: ScreenStates.error, error: l));
        }, (r) {
          isFirstLoading = false;
          if (r.isEmpty) {
            isLast = true;
            // pendingFilter.skipCount = 0;
          }
          vendorsList.addAll(r);
          emit(state.copyWith(
              screenStates: ScreenStates.success, vendorsList: vendorsList));
        });
      }
      if (event is ChangeFavoriteStatus) {
        int targetedIndex =
            vendorsList.indexWhere((element) => element.id == event.vendorId);
        if (vendorsList[targetedIndex].favoriteStatus) {
          vendorsList[targetedIndex].favoriteStatus = false;
          // emit(SearchCategorySuccess(vendorsList));
          emit(state.copyWith(
              screenStates: ScreenStates.success, vendorsList: vendorsList));
          final response =
              await FavoriteRepository.removeFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = true;
            // emit(SearchCategorySuccess(vendorsList));
            emit(state.copyWith(
                screenStates: ScreenStates.success, vendorsList: vendorsList));
          }, (r) {});
        } else {
          vendorsList[targetedIndex].favoriteStatus = true;
          emit(SearchCategorySuccess(vendorsList));
          final response = await FavoriteRepository.addFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = false;
            emit(state.copyWith(
                screenStates: ScreenStates.success, vendorsList: vendorsList));
            // emit(SearchCategorySuccess(vendorsList));
          }, (r) {});
        }
      }
    });
  }
}
