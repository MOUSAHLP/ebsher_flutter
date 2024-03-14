
import 'package:absher/bloc/vendors_exhibitions_bloc/vendors_exhibitions_event.dart';
import 'package:absher/bloc/vendors_exhibitions_bloc/vendors_exhibitions_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/data/repos/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import '../../data/repos/exhibitions_repository.dart';
import '../../models/params/get_vendors_exhibitions_params.dart';
import '../../models/sub_category_item_model.dart';

class VendorsExhibitionsBloc extends Bloc<VendorsExhibitionsEvent, VendorsExhibitionsState> {
  GetVendorsExhibitionsParams appliedFilter;
  GetVendorsExhibitionsParams pendingFilter = GetVendorsExhibitionsParams();
  ItemScrollController vendorsInnerController = ItemScrollController();
  final ScrollController scrollController = ScrollController();
  List<SubCategoryItemModel> subCategories = [];
  int maxCount = 10;

  VendorsExhibitionsBloc({required this.appliedFilter})
      : super(VendorsExhibitionsState(
          appliedFilters: appliedFilter,
          pendingFilters: appliedFilter,
        )) {
    scrollController.addListener(_scrollListener);
    on<VendorsExhibitionsEvent>((event, emit) async {
      if (event is GetVendorsList) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        appliedFilter.maxCount = maxCount;
        appliedFilter.skipCount = state.vendorsList.length;
        appliedFilter.exhibitionsId = event.subCategoryId;
        pendingFilter = GetVendorsExhibitionsParams.fromGetVendorsParams(appliedFilter);
        final response = await ExhibitionsRepository.getVendorsExhibitionsList(
            getVendorsParams: appliedFilter);
        response.fold((l) {
          if (l != 'Cancel') {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }
        }, (r) {
          final hasMoreData = r.length == appliedFilter.maxCount;

          emit(state.copyWith(
            screenStates: ScreenStates.success,
            vendorsList: [...state.vendorsList, ...r],
            // vendorsList: r,
            pendingFilters: pendingFilter,
            appliedFilters: appliedFilter,
            hasMoreData: hasMoreData,
          ));
        });
      }
      if (event is GetVendorsListPagination) {
        emit(state.copyWith(isLoading: true));
        appliedFilter.maxCount = maxCount;
        appliedFilter.skipCount = state.vendorsList.length;
        appliedFilter.exhibitionsId = event.subCategoryId;
        pendingFilter = GetVendorsExhibitionsParams.fromGetVendorsParams(appliedFilter);
        final response = await ExhibitionsRepository.getVendorsExhibitionsList(
            getVendorsParams: appliedFilter);
        response.fold((l) {
          if (l != 'Cancel') {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }
        }, (r) {
          final hasMoreData = r.length == appliedFilter.maxCount;
          emit(state.copyWith(
              screenStates: ScreenStates.success,
              vendorsList: [...state.vendorsList, ...r],
              pendingFilters: pendingFilter,
              appliedFilters: appliedFilter,
              hasMoreData: hasMoreData,
              isLoading: false));
        });
      }
      if (event is RefreshVendorsList) {
        emit(state.copyWith(screenStates: ScreenStates.loading, appliedFilters: appliedFilter));
        state.vendorsList.clear();
        appliedFilter.maxCount = maxCount;
        appliedFilter.skipCount = state.vendorsList.length;

        pendingFilter = GetVendorsExhibitionsParams.fromGetVendorsParams(appliedFilter);
        final response = await ExhibitionsRepository.getVendorsExhibitionsList(
            getVendorsParams: appliedFilter);
        response.fold((l) {
          if (l != 'Cancel') {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }
        }, (r) {
          final hasMoreData = r.length == appliedFilter.maxCount;
          emit(state.copyWith(
            screenStates: ScreenStates.success,
            vendorsList: [...state.vendorsList, ...r],
            pendingFilters: pendingFilter,
            appliedFilters: appliedFilter,
            hasMoreData: hasMoreData,
          ));
        });
      }

      if (event is ChangeVendorsListFavoriteStatus) {
        int targetedIndex = state.vendorsList
            .indexWhere((element) => element.id == event.vendorId);
        print("state.vendorsList");
        print(state.vendorsList);
        if (state.vendorsList[targetedIndex].favoriteStatus) {
          state.vendorsList[targetedIndex].favoriteStatus = false;
          emit(state.copyWith(
            vendorsList: state.vendorsList,
          ));
          final response =
              await FavoriteRepository.removeFavorite(event.vendorId);
          response.fold((l) {
            state.vendorsList[targetedIndex].favoriteStatus = true;
            emit(state.copyWith(vendorsList: state.vendorsList));
          }, (r) {});
        } else {
          state.vendorsList[targetedIndex].favoriteStatus = true;
          emit(state.copyWith(vendorsList: state.vendorsList));

          final response = await FavoriteRepository.addFavorite(event.vendorId);
          response.fold((l) {
            state.vendorsList[targetedIndex].favoriteStatus = false;
            emit(state.copyWith(vendorsList: state.vendorsList));
          }, (r) {});
        }
      }



      //// Todo




    });
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (state.isLoading != true && state.hasMoreData) {
        add(GetVendorsListPagination(
            appliedFilter.exhibitionsId ?? 0, subCategories));
      }
    }
  }
}
