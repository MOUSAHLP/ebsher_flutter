import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/data/repos/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repository.dart';
import '../../models/params/get_vendors_params.dart';
import '../../models/vendor_model.dart';

class VendorsListBloc extends Bloc<VendorsListEvent, VendorsListState> {
  GetVendorsParams appliedFilter = GetVendorsParams();
  GetVendorsParams pendingFilter = GetVendorsParams();

  List<VendorModel> vendorsList = [];

  VendorsListBloc()
      : super(VendorsListState(
          appliedFilters: GetVendorsParams(),
          pendingFilters: GetVendorsParams(),
        )) {
    on<VendorsListEvent>((event, emit) async {
      if (event is GetVendorsList) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        vendorsList.clear();
        appliedFilter.subCategoryId = event.idCategory;
        pendingFilter = GetVendorsParams.fromGetVendorsParams(appliedFilter);
        final response = await HomeRepository.getVendorsList(
            getVendorsParams: appliedFilter);
        response.fold((l) {
          emit(state.copyWith(screenStates: ScreenStates.error, error: l));
        }, (r) {
          vendorsList = [...r];
          emit(state.copyWith(
            screenStates: ScreenStates.success,
            vendorsList: vendorsList,
            pendingFilters: pendingFilter,
            appliedFilters: appliedFilter,
          ));
        });
      }

      if (event is RefreshVendorsList) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        vendorsList.clear();
        pendingFilter = GetVendorsParams.fromGetVendorsParams(appliedFilter);
        final response = await HomeRepository.getVendorsList(
            getVendorsParams: appliedFilter);
        response.fold((l) {
          emit(state.copyWith(screenStates: ScreenStates.error, error: l));
        }, (r) {
          vendorsList = [...r];
          emit(state.copyWith(
            screenStates: ScreenStates.success,
            vendorsList: vendorsList,
            pendingFilters: pendingFilter,
            appliedFilters: appliedFilter,
          ));
        });
      }

      if (event is ChangeVendorsListFavoriteStatus) {
        int targetedIndex =
            vendorsList.indexWhere((element) => element.id == event.vendorId);
        if (vendorsList[targetedIndex].favoriteStatus) {
          vendorsList[targetedIndex].favoriteStatus = false;
          emit(state.copyWith(
            vendorsList: vendorsList,
          ));
          final response =
              await FavoriteRepository.removeFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = true;
            emit(state.copyWith(vendorsList: vendorsList));
          }, (r) {});
        } else {
          vendorsList[targetedIndex].favoriteStatus = true;
          emit(state.copyWith(vendorsList: vendorsList));

          final response = await FavoriteRepository.addFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = false;
            emit(state.copyWith(vendorsList: vendorsList));
          }, (r) {});
        }
      }

      if (event is SetPendingSortingValue) {
        pendingFilter = pendingFilter.setNewSortingValue(
          getVendorsParams: event.getVendorsParams,
        );
        emit(state.copyWith(pendingFilters: pendingFilter));
      }

      if (event is ToggleIsOpenFilter) {
        if (pendingFilter.isOpen == true) {
          pendingFilter.isOpen = null;
        } else {
          pendingFilter.isOpen = true;
        }
        emit(state.copyWith(pendingFilters: pendingFilter));
      }

      if (event is ToggleNearByFilter) {
        if (pendingFilter.lat == null) {
          ///TODO ADD GET LOCATION FUNCTION
          pendingFilter.lat = 33.333;
          pendingFilter.lon = 33.3333;
        } else {
          pendingFilter.lat = null;
          pendingFilter.lon = null;
        }
        emit(state.copyWith(pendingFilters: pendingFilter));
      }

      if (event is SetByRateFilter) {
        pendingFilter.rate = event.newRateValue;
        emit(state.copyWith(pendingFilters: pendingFilter));
      }

      if (event is ResetPendingFilterParams) {
        pendingFilter = GetVendorsParams.fromGetVendorsParams(appliedFilter);
        emit(state.copyWith(pendingFilters: pendingFilter));
      }

      if (event is SetAppliedFilter) {
        appliedFilter = GetVendorsParams.fromGetVendorsParams(pendingFilter);
        emit(state.copyWith(appliedFilters: appliedFilter));
      }

      if (event is ClearFilterValues) {
        pendingFilter.lat = null;
        pendingFilter.lon = null;
        pendingFilter.isOpen = null;
        pendingFilter.rate = null;
        emit(state.copyWith(pendingFilters: pendingFilter));
      }

      if (event is ClearSortValue) {
        pendingFilter.sortByName = null;
        pendingFilter.recent = null;
        pendingFilter.visits = null;
        emit(state.copyWith(pendingFilters: pendingFilter));
      }
    });
  }
}
