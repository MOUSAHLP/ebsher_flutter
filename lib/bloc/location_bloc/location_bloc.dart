import 'package:absher/bloc/location_bloc/location_event.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/repos/location_respository.dart';
import '../../models/vendor_model.dart';
import '../../presentation/screens/location_screen/widgets/marker.dart';
import 'location_state.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  var latitudeCurrent = 0.0, longitudeCurrent = 0.0;
  GoogleMapController? mapController;
  Position? position;
  List<VendorModel> vendorList=[];
  List<VendorModel> vendorListBinding=[];
  List<VendorModel> vendorListSelected=[];
  List<MarkerData> customMarkers=[];
  List<MarkerData> myMarkFilter=[];
  Future<void> getPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitudeCurrent = position!.latitude;
    longitudeCurrent = position!.longitude;
    myMarkFilter.add(
      MarkerData(
          marker:
          Marker(markerId:   const MarkerId("current"), position:  LatLng(latitudeCurrent , longitudeCurrent ), ),
          child:Image.asset( ImageManager.locationMap,width:100,height: 100,)),
    );
    customMarkers.add(
      MarkerData(
          marker:
          Marker(markerId:   const MarkerId("current1"), position:  LatLng(latitudeCurrent , longitudeCurrent ), ),
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
          child: MarkerWidget(image: vendorList[i].logo!)
          ,),
      );

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
      ),child: MarkerWidget(image: vendorListSelected[i].logo!)));
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
          emit(state.copyWith(latitude: latitudeCurrent,longitude: longitudeCurrent,vendorList: vendorList,vendorSelected:vendorList,
              myMark: customMarkers ));
        });
      }
      if(event is FilterVendors){
        vendorListSelected.clear();
        vendorListSelected=[...vendorListBinding];
        addMarkerFilter();
        emit(state.copyWith(myMark: myMarkFilter,vendorSelected:vendorListSelected ,index: -1,check: !state.check ));
      }
      if(event is ClickMarker){
        emit(state.copyWith(index: event.index));
      }
      if (event is IndexIncrement) {
        int indexIncrement = state.index ;
        if(indexIncrement==state.vendorSelected.length-1)
        {
          mapController
              ?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                  double.parse(state
                      .vendorSelected[0]
                      .latitude!),
                  double.parse(state
                      .vendorSelected[0]
                      .longitude!)),
              16));

          emit(state.copyWith(index:0 ));


        }
        else{
          mapController
              ?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                  double.parse(state
                      .vendorSelected[state.index+1]
                      .latitude!),
                  double.parse(state
                      .vendorSelected[state.index+1]
                      .longitude!)),
              16));
          emit(state.copyWith(index:indexIncrement+1));
        }
      }
      if (event is IndexDecrement) {

        int indexIncrement = state.index ;
        if(indexIncrement==0)
        {
          mapController
            ?.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(
                double.parse(state
                    .vendorSelected[state.vendorSelected.length-1]
                    .latitude!),
                double.parse(state
                    .vendorSelected[state.vendorSelected.length-1]
                    .longitude!)),
            16));
          emit(state.copyWith(index:state.vendorSelected.length-1 ));}
        else{
          mapController
              ?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(
                  double.parse(state
                      .vendorSelected[indexIncrement-1]
                      .latitude!),
                  double.parse(state
                      .vendorSelected[indexIncrement-1]
                      .longitude!)),
              16));
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
