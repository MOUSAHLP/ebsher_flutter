import 'package:absher/bloc/location_bloc/location_event.dart';
import 'package:absher/bloc/location_bloc/location_state.dart';
import 'package:absher/core/app_router/app_router.dart';
import 'package:absher/core/extensions.dart';
import 'package:absher/presentation/screens/location_screen/widgets/app_bar_widget.dart';
import 'package:absher/presentation/screens/location_screen/widgets/arrow_button.dart';
import 'package:absher/presentation/screens/location_screen/widgets/filter_button.dart';
import 'package:absher/presentation/screens/location_screen/widgets/location_card.dart';
import 'package:absher/presentation/widgets/custom_app_background.dart';
import 'package:absher/presentation/widgets/custom_error_screen.dart';
import 'package:absher/translations.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../bloc/location_bloc/location_bloc.dart';
import '../../../core/localization_string.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../../widgets/custom_button.dart';
import '../vendors_screen/vendors_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAppBackGround(
        child: BlocProvider<LocationBloc>(
          create: (BuildContext context) =>
          sl<LocationBloc>()..add(CurrentLocation()),
          child: const LocationScreenBody(),
        ),
      ),
    );
  }
}
class LocationScreenBody extends StatelessWidget {
  const LocationScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {
           if(state is CurrentLocationNoPermission){
            AppRouter.pop(context);
            }
          },
            builder: (context, state) {
              if (state is CurrentLocationLoading) {
                return  Column(
                  children: [
                    const SizedBox(height: 60),
                    const LinearProgressIndicator(
                      backgroundColor: ColorManager.primaryColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 40),
                    Text(AppLocalizations.of(context)!.location,style: getBoldStyle(color: Colors.white,fontSize: 16),)
                  ],
                );
              } else if (state is CurrentLocationError) {
                return CustomErrorScreen(
                  onTap: () {
                    sl<LocationBloc>().add(CurrentLocation());
                  },
                );
              }
              else {
                return SafeArea(
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CustomGoogleMapMarkerBuilder(
                              customMarkers: state.myMark!,
                              builder: ( context, Set<Marker>? markers) {
                                return GoogleMap(
                                  zoomControlsEnabled: false,
                                  markers:  markers ?? Set<Marker>(),
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(state.latitude, state.longitude),
                                    zoom: 18,
                                  ),
                                  onMapCreated: (GoogleMapController controller) {
                                    context.read<LocationBloc>().mapController =
                                        controller;
                                    LatLng location =
                                    LatLng(state.latitude, state.longitude);
                                    controller.animateCamera(
                                        CameraUpdate.newLatLngZoom(location, 14));
                                  },
                                );
                              })),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(19)),
                              height: 50,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          context
                                              .read<LocationBloc>()
                                              .mapController
                                              ?.animateCamera(
                                              CameraUpdate.newLatLngZoom(
                                                  LatLng(state.latitude,
                                                      state.longitude),
                                                  16));
                                        },
                                        child: SvgPicture.asset(
                                            IconsManager.iconLocation)),
                                    const SizedBox(width: 10),
                                    Text(
                                      AppLocalizations.of(context)!.selectLocation,
                                      style: getBoldStyle(
                                        color: ColorManager.primaryColor,
                                        fontSize: FontSizeApp.s14,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(56),
                                                ),
                                              ),
                                              context: context,
                                              builder: (BuildContext context1) {
                                                return BlocBuilder<LocationBloc,
                                                    LocationState>(
                                                    bloc: context.read<LocationBloc>(),
                                                    builder: (contextBottom, state) {
                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8.0),
                                                              child: Center(
                                                                child: Container(
                                                                  width: 50,
                                                                  height: 4,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorManager
                                                                          .labelGrey,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          50)),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  32.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 200,
                                                                    child: ListView
                                                                        .builder(
                                                                      itemBuilder:
                                                                          (context1,
                                                                          index) {
                                                                        return GestureDetector(
                                                                          onTap: () {
                                                                            context
                                                                                .read<
                                                                                LocationBloc>()
                                                                                .add(checkIndex(
                                                                                index));
                                                                          },
                                                                          child: FilterButtonLocation(
                                                                              label:
                                                                              LocalixationString(context,state
                                                                                  .vendorList[
                                                                              index]
                                                                                  .name) ?? ""
                                                                             ,
                                                                              isSelected: state.vendorBinding.any((element) =>
                                                                              element
                                                                                  .id ==
                                                                                  state
                                                                                      .vendorList[index]
                                                                                      .id),
                                                                          image:state
                                                                              .vendorList[
                                                                          index]
                                                                              .category!.thumbnail!,
                                                                          color:state
                                                                              .vendorList[
                                                                          index]
                                                                              .category!.color!! ),
                                                                        );
                                                                      },
                                                                      itemCount: state
                                                                          .vendorList
                                                                          .length,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(8.0),
                                                                    child: CustomButton(
                                                                      label: AppLocalizations.of(context)!.app,
                                                                      fillColor:
                                                                      ColorManager
                                                                          .primaryColor,
                                                                      onTap: () {
                                                                        context
                                                                            .read<
                                                                            LocationBloc>()
                                                                            .add(
                                                                            (FilterVendors()));
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                        8.0,
                                                                        horizontal:
                                                                        64),
                                                                    child: CustomButton(
                                                                      label: AppLocalizations.of(context)!.closeVendor,
                                                                      fillColor:
                                                                      ColorManager
                                                                          .primaryColor,
                                                                      isFilled: false,
                                                                      labelColor:
                                                                      ColorManager
                                                                          .primaryColor,
                                                                      onTap: () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              });
                                        },
                                        child:
                                        SvgPicture.asset(IconsManager.iconFilter))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      state.index == -1
                          ? const Text("")
                          : Positioned(
                        left: 10,
                        right: 10,
                        bottom: 15,
                        child: Row(
                          children: [
                            ArrowButton(
                                image: IconsManager.iconLeftArrow,
                                onTap: () {
                                  context
                                      .read<LocationBloc>()
                                      .add(IndexIncrement());
                                }),
                            const SizedBox(width: 5),
                            LocationCard(
                                vendorModel:
                                state.vendorSelected[state.index]),
                            const SizedBox(
                              width: 5,
                            ),
                            ArrowButton(
                                image: IconsManager.iconRightArrow,
                                onTap: () {
                                  context
                                      .read<LocationBloc>()
                                      .add(IndexDecrement());
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
        AppBarWidget(),
      ],
    );
  }
}

