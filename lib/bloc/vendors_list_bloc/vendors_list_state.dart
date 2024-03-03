import 'package:absher/core/app_enums.dart';
import 'package:absher/models/city_name_model.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/vendor_model.dart';

@immutable
class VendorsListState extends Equatable {
  final ScreenStates screenStates;
  final List<VendorModel> vendorsList;
  final GetVendorsParams appliedFilters;
  final GetVendorsParams pendingFilters;
  final String error;
  final bool showLoadingDialog;
  bool isLoading;
  final bool hasMoreData;
  int currentPage;
  CityNameModel? cityName;
  CityNameModel? regionsName;
  String? selectedTheCityName;
  String? selectedTheRegionsName;
  int? idCityName;
  int? idRegionsName;
  bool isSelectedTheCityName;

  VendorsListState({
    this.screenStates = ScreenStates.loading,
    this.vendorsList = const [],
    required this.appliedFilters,
    required this.pendingFilters,
    this.error = 'Unknown Error',
    this.showLoadingDialog = false,
    this.hasMoreData = false,
    this.isLoading = false,
    this.currentPage = 0,
    this.idCityName = 1,
    this.idRegionsName = 0,
    this.cityName,
    this.regionsName,
    this.selectedTheCityName = 'المزة',
    this.selectedTheRegionsName = '',
    this.isSelectedTheCityName = false,
  }) : super();

  VendorsListState copyWith({
    List<VendorModel>? vendorsList,
    GetVendorsParams? appliedFilters,
    GetVendorsParams? pendingFilters,
    ScreenStates? screenStates,
    String? error,
    bool? showLoadingDialog,
    bool? hasMoreData,
    bool? isLoading,
    int? currentPage,
    String? selectedTheCityName,
    String? selectedTheRegionsName,
    CityNameModel? cityName,
    CityNameModel? regionsName,
    int? idCityName,
    int? idRegionsName,
    bool? isSelectedTheCityName,
  }) {
    return VendorsListState(
      screenStates: screenStates ?? this.screenStates,
      vendorsList:
          vendorsList != null ? List.from(vendorsList) : this.vendorsList,
      appliedFilters: appliedFilters != null
          ? GetVendorsParams.fromGetVendorsParams(appliedFilters)
          : this.appliedFilters,
      pendingFilters: pendingFilters != null
          ? GetVendorsParams.fromGetVendorsParams(pendingFilters)
          : this.pendingFilters,
      error: error ?? this.error,
      showLoadingDialog: showLoadingDialog ?? this.showLoadingDialog,
      isLoading: isLoading ?? this.isLoading,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
      cityName: cityName ?? this.cityName,
      regionsName: regionsName ?? this.regionsName,
      selectedTheCityName: selectedTheCityName ?? this.selectedTheCityName,
      selectedTheRegionsName:
          selectedTheRegionsName ?? this.selectedTheRegionsName,
      idCityName: idCityName ?? this.idCityName,
      idRegionsName: idRegionsName ?? this.idRegionsName,
      isSelectedTheCityName:
          isSelectedTheCityName ?? this.isSelectedTheCityName,
    );
  }

  @override
  List<Object?> get props => [
        identityHashCode(this),
        vendorsList,
        appliedFilters,
        pendingFilters,
        screenStates,
        error,
        showLoadingDialog,
        hasMoreData,
        isLoading,
        currentPage,
        cityName,
        selectedTheCityName,
        selectedTheRegionsName,
        regionsName,
        idCityName,
    idRegionsName,
        isSelectedTheCityName,
      ];
}
