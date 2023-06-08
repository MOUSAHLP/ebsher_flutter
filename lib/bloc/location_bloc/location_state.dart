

import 'package:absher/models/vendor_model.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/vendors_near_model.dart';



class CurrentLocationLoading extends LocationState {
}
class CurrentLocationError extends LocationState {
  String error;
  CurrentLocationError(this.error);
}
 class LocationState extends Equatable {
   LocationState({
    this.latitude = 0,
    this.longitude = 0.0,
    this.myMark=const [],
      this.vendorList = const [],
      this.vendorSelected = const [],
      this.vendorBinding = const [],

     this.index =-1,
     this.check=false

  });
  final double latitude;
  final double longitude;
   List<MarkerData>? myMark ;

  List<VendorModel> vendorList;
  List<VendorModel> vendorSelected;
  List<VendorModel> vendorBinding;
  int index;
  bool check;
  LocationState copyWith({
     double? latitude,
     double? longitude,
    List<MarkerData>? myMark ,
      List<VendorModel>? vendorList,
      List<VendorModel>? vendorSelected,
      List<VendorModel>? vendorBinding,

    int? index,
    bool? check
  }) {
    return LocationState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      myMark: myMark ?? this.myMark,
      vendorList: vendorList ?? this.vendorList,
      vendorSelected: vendorSelected ?? this.vendorSelected,
      index: index ?? this.index,
      vendorBinding: vendorBinding ?? this.vendorBinding,

      check: check ?? this.check,
    );
  }

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    myMark,
    vendorList,
    index,
    vendorBinding,
    check,vendorSelected
  ];
}
class ExitStories extends LocationState {}
