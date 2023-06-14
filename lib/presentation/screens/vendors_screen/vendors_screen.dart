import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/font_app.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/build_shimmer_vendors.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/card_random.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:absher/presentation/widgets/custom_button.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      create: (BuildContext context) => sl<VendorsListBloc>()
        ..add(GetVendorsList(categoryId)
            ),
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
          BlocBuilder<VendorsListBloc, VendorsListState>(
              builder: (context, state) {
            if (state is VendorsListLoading) {
              return const BuildShimmerVendors();
            } else if (state is VendorsListError) {
              return CustomErrorScreen(
                onTap: () {
                  sl<VendorsListBloc>().add(GetVendorsList(categoryId));
                },
              );
            } else if (state is VendorsListSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(56),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Center(
                                        child: Container(
                                          width: 50,
                                          height: 4,
                                          decoration: BoxDecoration(
                                              color: ColorManager.labelGrey,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FilterButton(
                                            label: AppLocalizations.of(context)!.oldest,
                                            isSelected: true,
                                          ),
                                          FilterButton(
                                            label: AppLocalizations.of(context)!.latest,
                                            isSelected: false,
                                          ),
                                          FilterButton(
                                            label: AppLocalizations.of(context)!.descending,
                                            isSelected: false,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomButton(
                                              label:  AppLocalizations.of(context)!.app,
                                              fillColor:
                                                  ColorManager.primaryColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 64),
                                            child: CustomButton(
                                              label: AppLocalizations.of(context)!.cancel,
                                              fillColor:
                                                  ColorManager.primaryColor,
                                              isFilled: false,
                                              labelColor:
                                                  ColorManager.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(19)),
                          height: 50,
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.compare_arrows_rounded,
                                    color: ColorManager.primaryColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.sort,
                                  style: getBoldStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: FontSizeApp.s14,
                                  ),
                                ),
                                Spacer(),
                                SvgPicture.asset(IconsManager.iconFilter)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    state.vendorsList.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return CardRandomWidget(
                                vendor: state.vendorsList[index],
                              );
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.vendorsList.length,
                            shrinkWrap: true,
                          )
                        : const Center(child: CustomNoDataScreen()),
                  ],
                ),
              );
            } else {
              return const Text("");
            }
          }),
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

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key, required this.isSelected, required this.label})
      : super(key: key);
  final bool isSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: getBoldStyle(
                color: isSelected
                    ? ColorManager.softYellow
                    : ColorManager.labelGrey,
                fontSize: FontSizeApp.s16,
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Icon(
                Icons.circle,
                size: 16,
                color: ColorManager.softYellow,
              ),
            )
          ],
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
