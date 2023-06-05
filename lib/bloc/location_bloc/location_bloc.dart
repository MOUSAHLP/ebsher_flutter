


import 'package:absher/bloc/location_bloc/location_event.dart';
import 'package:absher/presentation/resources/assets_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/repos/location_respository.dart';
import '../../models/vendors_near_model.dart';
import 'location_state.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  var latitudeCurrent = 0.0, longitudeCurrent = 0.0;
  bool check=true;
  GoogleMapController? mapController;
  Position? position;
  List<VendorsNearModel> vendorList=[];
  List<VendorsNearModel> vendorListBinding=[];
  List<VendorsNearModel> vendorListSelected=[];
//  Set<Marker> myMark = {};
   List<MarkerData> customMarkers=[];
   List<MarkerData> myMarkFilter=[];

//  Set<Marker> myMarkFilter = {};
  _customMarker(String symbol, Color color) {
    print(symbol);
    return Stack(
      children: [
        Icon(
          Icons.add_location,
          color: color,
          size: 50,
        ),
        Positioned(
          left: 15,
          top: 8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(child: ClipRRect(
                borderRadius: BorderRadius.circular(50),child: Image.network(symbol))),
          ),
        )
      ],
    );
  }
  Future<void> getPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitudeCurrent = position!.latitude;
    longitudeCurrent = position!.longitude;
    BitmapDescriptor markerMap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(164,264)),
      ImageManager.locationMap,
    );
    myMarkFilter.add(
      MarkerData(
          marker:
          Marker(markerId:   MarkerId("current"), position:  LatLng(latitudeCurrent , longitudeCurrent ), ),
          child:Image.asset( ImageManager.locationMap,width:100,height: 100,)),
    );
    customMarkers.add(
      MarkerData(
          marker:
          Marker(markerId:   MarkerId("current1"), position:  LatLng(latitudeCurrent , longitudeCurrent ), ),
          child:Image.asset( ImageManager.locationMap,width:100,height: 100,)),
    );

  }
  addMarker(){
    for(int i=0;i<vendorList.length;i++){

      customMarkers.add(
        MarkerData(
            marker:
            Marker(markerId:   MarkerId("$i"),
              position:  LatLng(double.parse(vendorList[i].latitude??"0") , double.parse(vendorList[i].longitude??"0") ),onTap: (){
                  add(ClickMarker(i));
                } ),
            child: _customMarker(vendorList[i].logo!, Colors.blue)
        ,),
      );
//        myMark.add(Marker(
//          draggable: false,
//          markerId:  MarkerId("$i"),
//          position: LatLng(double.parse(vendorList[i].latitude??"0") , double.parse(vendorList[i].longitude??"0") ), //position of marker
//          icon: BitmapDescriptor.defaultMarkerWithHue( i.isOdd?BitmapDescriptor.hueGreen:BitmapDescriptor.hueRose) ,
//            onTap: () {
//            add(ClickMarker(i));
//            }
//        ));
    }
  }
  addMarkerFilter(){
    for(int i=0;i<vendorListSelected.length;i++){
        myMarkFilter.add(MarkerData(marker:  Marker(
          draggable: false,
          markerId:  MarkerId("$i"),
          position: LatLng(double.parse(vendorListSelected[i].latitude??"0") , double.parse(vendorListSelected[i].longitude??"0") ), //position of marker
             onTap: () {
            add(ClickMarker(i));
            }
        ),child: _customMarker(vendorList[i].logo!, Colors.blue)));
    }
  }
  LocationBloc() : super(LocationState()) {
    on< LocationEvent>((event, emit) async {
      if(event is CurrentLocation){
        emit(CurrentLocationLoading());
       await getPosition();
        final response =
        await LocationRepository.getVendorsNear(latitude: latitudeCurrent, longitude: longitudeCurrent);
        response.fold((l) {
          emit(CurrentLocationError(l));
        }, (r) {
          vendorList=r;
          addMarker();
          emit(state.copyWith(latitude: latitudeCurrent,longitude: longitudeCurrent,vendorList: vendorList,vendorSelected:r,
              myMark: customMarkers ));
        });
      }
      if(event is FilterVendors){
        vendorListSelected.clear();
        vendorListSelected=[...vendorListBinding];
        addMarkerFilter();
        emit(state.copyWith(myMark: myMarkFilter,vendorList: vendorList,vendorSelected:vendorListSelected ,index: -1));
      }
      if(event is ClickMarker){
        emit(state.copyWith(index: event.index));
      }
      if (event is IndexIncrement) {
        int indexIncrement = state.index ;
        if(indexIncrement==vendorListSelected.length-1)
      {emit(state.copyWith(index:0 ));}
        else{
          emit(state.copyWith(index:indexIncrement+1));
        }
      }
      if (event is IndexDecrement) {
        int indexIncrement = state.index ;
        if(indexIncrement==0)
        {
          emit(state.copyWith(index:vendorListSelected.length-1 ));}
        else{
          emit(state.copyWith(index:indexIncrement-1));
        }
      }
      if(event is checkIndex){
       if(vendorListBinding
           .any((element) => element.id==vendorList[event.index].id)){
         vendorListBinding.remove(vendorList[event.index]);
         emit(state.copyWith(vendorBinding:vendorListBinding,check: !state.check));
       }
        else{
         vendorListBinding.add(vendorList[event.index]);
         emit(state.copyWith(vendorBinding:vendorListBinding,check: !state.check));
       }
      }

    });
  }
}
