import 'dart:developer';

import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/build_shimmer_vendors.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/search_filters.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/services/services_locator.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({Key? key, required this.title, required this.categoryId})
      : super(key: key);

  final String title;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VendorsListBloc>(
      create: (BuildContext context) =>
          sl<VendorsListBloc>()..add(GetVendorsList(categoryId)),
      // lazy: false,
      child: VendorsScreenBody(
        title: title,
        categoryId: categoryId,
      ),
    );
  }
}

class VendorsScreenBody extends StatelessWidget {
  final String title;
  final int categoryId;

  const VendorsScreenBody(
      {super.key, required this.title, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBackGround(
          child: SafeArea(
              child: Stack(
        children: [
          Stack(
            children: [
              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 0,
                top: 140,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 96,
                  decoration: const BoxDecoration(
                      color: ColorManager.softYellow,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(50))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.sh,
            child: BlocBuilder<VendorsListBloc, VendorsListState>(
                buildWhen: (prev, current) {
              return prev.screenStates != current.screenStates;
            }, builder: (context, state) {
              if (state.screenStates == ScreenStates.loading) {
                return const BuildShimmerVendors();
              } else if (state.screenStates == ScreenStates.error) {
                return Column(
                  children: [
                    CustomErrorScreen(
                      onTap: () {
                        context
                            .read<VendorsListBloc>()
                            .add(GetVendorsList(categoryId));
                      },
                    ),
                  ],
                );
              } else if (state.screenStates == ScreenStates.success) {
                return state.vendorsList.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),
                          const SearchFilter(),
                          const SizedBox(height: 40),
                          Expanded(
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (over) {
                                over.disallowIndicator();
                                return true;
                              },
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  context
                                      .read<VendorsListBloc>()
                                      .add(GetVendorsList(categoryId));
                                },
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return CardRandomWidget(
                                      vendor: state.vendorsList[index],
                                    );
                                  },
                                  itemCount: state.vendorsList.length,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(height: 70),
                          SearchFilter(),
                          SizedBox(height: 40),
                          Expanded(
                            child: CustomNoDataScreen(),
                          )
                        ],
                      );
              } else {
                return const Text("");
              }
            }),
          ),
          Stack(
            children: [
              CustomAppBarScreens(
                title: title,
              ),
            ],
          ),
        ],
      ))),
    );
  }
}
