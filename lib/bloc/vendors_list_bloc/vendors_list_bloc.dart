import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/data/repos/favorite_repository.dart';
import 'package:absher/models/city_name_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import '../../data/repos/home_repository.dart';
import '../../models/params/get_vendors_params.dart';
import '../../models/sub_category_item_model.dart';
import '../../models/vendor_model.dart';

class VendorsListBloc extends Bloc<VendorsListEvent, VendorsListState> {
  GetVendorsParams appliedFilter;
  GetVendorsParams pendingFilter = GetVendorsParams();
  ItemScrollController vendorsInnerController = ItemScrollController();
  final ScrollController scrollController = ScrollController();
  List<SubCategoryItemModel> subCategories = [];
  int maxCount = 10;

  VendorsListBloc({required this.appliedFilter})
      : super(VendorsListState(
          appliedFilters: appliedFilter,
          pendingFilters: appliedFilter,
        )) {
    scrollController.addListener(_scrollListener);
    on<VendorsListEvent>((event, emit) async {
      if (event is GetVendorsList) {
        emit(state.copyWith(screenStates: ScreenStates.loading));
        appliedFilter.maxCount = maxCount;
        appliedFilter.skipCount = state.vendorsList.length;
        appliedFilter.subCategoryId = event.subCategoryId;
        pendingFilter = GetVendorsParams.fromGetVendorsParams(appliedFilter);
        final response = await HomeRepository.getVendorsList(
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
        appliedFilter.subCategoryId = event.subCategoryId;
        pendingFilter = GetVendorsParams.fromGetVendorsParams(appliedFilter);
        final response = await HomeRepository.getVendorsList(
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
      if (event is ChangeSelectedSubCategory) {
        appliedFilter.subCategoryId = event.subCategoryId;
        add(RefreshVendorsList());
      }
      if (event is RefreshVendorsList) {
        emit(state.copyWith(screenStates: ScreenStates.loading, appliedFilters: appliedFilter));
        state.vendorsList.clear();
        appliedFilter.maxCount = maxCount;
        appliedFilter.skipCount = state.vendorsList.length;
        print('-----------regionIdPara---------------');
        print('-----------regionIdPara---------------');
        print('-----------regionIdPara---------------');
        print(appliedFilter.regionIdPara);
        print(appliedFilter.cityIdPara);
        pendingFilter = GetVendorsParams.fromGetVendorsParams(appliedFilter);
        final response = await HomeRepository.getVendorsList(
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
          emit(state.copyWith(showLoadingDialog: true));
          Position? position = await getLocation();
          pendingFilter.lat = position?.latitude;
          pendingFilter.lon = position?.longitude;
        } else {
          pendingFilter.lat = null;
          pendingFilter.lon = null;
        }
        emit(state.copyWith(
            showLoadingDialog: false, pendingFilters: pendingFilter));
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
      if (event is ChangeStatusList) {
        event.vendorFavorit.favoriteStatus =
            !event.vendorFavorit.favoriteStatus;
        emit(state.copyWith(
          screenStates: ScreenStates.success,
        ));
      }


      if (event is GetCityNameEvent) {

        final response = await HomeRepository.getCityName();
        response.fold((l) {
          if (l != 'Cancel') {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }
        }, (r) {
          emit(state.copyWith(cityName: r));
        });
      }
      //// Todo
      if (event is SelectedCityNameEvent) {
        emit(state.copyWith(selectedTheCityName: state.selectedTheCityName,isSelectedTheCityName: false));
        pendingFilter.cityIdPara = state.idCityName;
      }

      if( event is GetRegionNameEvent) {
        final response = await HomeRepository.getRegionsName(state.idCityName!);
        response.fold((l) {
          if (l != 'Cancel') {
            emit(state.copyWith(screenStates: ScreenStates.error, error: l));
          }
        }, (r) {
          emit(state.copyWith(regionsName: r));
        });

        emit(state.copyWith(selectedTheRegionsName: state.regionsName!.data[state.idCityName!].name,isSelectedTheCityName: true));

      }

      if (event is SelectedRegionNameEvent) {
        emit(state.copyWith(selectedTheRegionsName: state.selectedTheRegionsName));
        pendingFilter.regionIdPara = state.idRegionsName;

      }
    });
  }

  Future<Position?> getLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        toast('Location services are disabled.');
        return null;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          toast('Location permissions are denied.');
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        toast(
            'Location permissions are permanently denied, we cannot request permissions.');
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (state.isLoading != true && state.hasMoreData) {
        add(GetVendorsListPagination(
            appliedFilter.subCategoryId ?? 0, subCategories));
      }
    }
  }
}
