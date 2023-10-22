


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../core/app_enums.dart';
import '../../models/vendor_model.dart';

// abstract class SearchState {}
// class SearchCategoryLoading extends SearchState{}
class SearchCategorySuccess extends SearchState{
  List<VendorModel> listSearch;
  SearchCategorySuccess(this.listSearch);
}
// class SearchCategoryError extends SearchState{
//   String error;
//   SearchCategoryError(this.error);
// }

@immutable
class SearchState extends Equatable {
  final ScreenStates screenStates;
   List<VendorModel> vendorsList;
  final String error;

  SearchState({
    this.screenStates = ScreenStates.init,
    this.vendorsList = const [],

    this.error = 'Unknown Error',

  }) : super();

  SearchState copyWith({
    List<VendorModel>? vendorsList,

    ScreenStates? screenStates,
    String? error,
    bool? showLoadingDialog,
    bool? hasMoreData,
    bool? loadingPagenation,
  }) {
    return SearchState(
      screenStates: screenStates ?? this.screenStates,
      vendorsList:
      vendorsList

        ?? this.vendorsList,

      error: error ?? this.error);

  }

  @override
  List<Object?> get props => [
    identityHashCode(this),
    vendorsList,

    screenStates,
    error,

  ];
}
