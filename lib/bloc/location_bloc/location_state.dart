import 'package:absher/core/app_enums.dart';
import 'package:absher/models/vendor_model.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:equatable/equatable.dart';

class LocationState extends Equatable {
  ScreenStates screenStates;

  String error;
  final double latitude;
  final double longitude;
  List<MarkerData>? myMark;
  List<VendorModel> vendorList;
  List<VendorModel> vendorSelected;
  List<Category> allCategories;
  List<Category> pendingCategories;
  List<Category> selectedCategories;
  int index;
  bool check;

  LocationState({
    this.latitude = 0,
    this.longitude = 0.0,
    this.myMark = const [],
    this.vendorList = const [],
    this.vendorSelected = const [],
    this.allCategories = const [],
    this.pendingCategories = const [],
    this.selectedCategories = const [],
    // this.vendorBinding = const [],
    this.index = -1,
    this.check = false,
    this.screenStates = ScreenStates.loading,
    this.error = '',
  });

  LocationState copyWith({
    double? latitude,
    double? longitude,
    List<MarkerData>? myMark,
    List<VendorModel>? vendorList,
    List<VendorModel>? vendorSelected,
    List<VendorModel>? vendorBinding,
    List<Category>? allCategories,
    List<Category>? pendingCategories,
    List<Category>? selectedCategories,
    int? index,
    bool? check,
    ScreenStates? screenStates,
    String? error,
  }) {
    return LocationState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      myMark: myMark ?? this.myMark,
      vendorList: vendorList ?? this.vendorList,
      vendorSelected: vendorSelected ?? this.vendorSelected,
      index: index ?? this.index,
      allCategories: allCategories ?? this.allCategories,
      pendingCategories: pendingCategories ?? this.pendingCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      check: check ?? this.check,
      screenStates: screenStates ?? this.screenStates,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        myMark,
        vendorList,
        index,
        allCategories,
        pendingCategories,
        selectedCategories,
        check,
        vendorSelected,
        screenStates,
        error,
      ];
}

class ExitLocation extends LocationState {}
