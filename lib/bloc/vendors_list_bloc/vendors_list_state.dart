import 'package:absher/core/app_enums.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:equatable/equatable.dart';

import '../../models/vendor_model.dart';

class VendorsListState extends Equatable {
  final ScreenStates screenStates;
  final List<VendorModel> vendorsList;
  final GetVendorsParams appliedFilters;
  final GetVendorsParams pendingFilters;
  final String error;

  const VendorsListState(
      {this.screenStates = ScreenStates.loading,
      this.vendorsList = const [],
      required this.appliedFilters,
      required this.pendingFilters,
      this.error = 'Unknown Error'});

  VendorsListState copyWith({
    List<VendorModel>? vendorsList,
    GetVendorsParams? appliedFilters,
    GetVendorsParams? pendingFilters,
    ScreenStates? screenStates,
    String? error,
  }) {
    return VendorsListState(
      screenStates: screenStates ?? this.screenStates,
      vendorsList: vendorsList != null ? [...vendorsList] : this.vendorsList,
      appliedFilters: appliedFilters != null
          ? GetVendorsParams.fromGetVendorsParams(appliedFilters)
          : this.appliedFilters,
      pendingFilters: pendingFilters != null
          ? GetVendorsParams.fromGetVendorsParams(pendingFilters)
          : this.pendingFilters,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        vendorsList,
        appliedFilters,
        pendingFilters,
        screenStates,
        error,
      ];
}

// class VendorsListLoading extends VendorsListState {}
//
// class VendorsListError extends VendorsListState {
//   String error;
//   VendorsListError(this.error);
// }
//
// class VendorsListSuccess extends VendorsListState  {
//   final List<VendorModel> vendorsList;
//   final GetVendorsParams appliedFilters;
//   final GetVendorsParams pendingFilters;
//   VendorsListSuccess(
//       {required this.vendorsList,
//       required this.appliedFilters,
//       required this.pendingFilters});
// }
