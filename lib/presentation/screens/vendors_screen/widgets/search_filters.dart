import 'dart:developer';

import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../bloc/vendors_list_bloc/vendors_list_event.dart';
import '../../../../bloc/vendors_list_bloc/vendors_list_event.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/dialogs/loading_dialog.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({
    Key? key,
    this.label,
  }) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.read<VendorsListBloc>().add(ResetPendingFilterParams());
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(56),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext builderContext) {
                    return BlocProvider.value(
                        value: BlocProvider.of<VendorsListBloc>(context),
                        child: SortBottomSheetBody());
                  });
            },
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(19)),
                  height: 50,
                  // width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.compare_arrows_rounded,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            filterBarLabel(context
                                    .read<VendorsListBloc>()
                                    .appliedFilter) ??
                                'Sort By',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: filterBarLabel(context
                                        .read<VendorsListBloc>()
                                        .appliedFilter) ==
                                    null
                                ? getBoldStyle(color: Colors.black)
                                : getBoldStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<VendorsListBloc>().add(ResetPendingFilterParams());
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(56),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext builderContext) {
                      return BlocProvider.value(
                          value: BlocProvider.of<VendorsListBloc>(context),
                          child: FilterBottomSheetBody());
                    });
              },
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19)),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconsManager.iconFilter,
                            height: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                filterBarLabel(context
                                        .read<VendorsListBloc>()
                                        .appliedFilter) ??
                                    'Add_New_Filters',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: filterBarLabel(context
                                            .read<VendorsListBloc>()
                                            .appliedFilter) ==
                                        null
                                    ? getBoldStyle(color: Colors.black)
                                    : getBoldStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? filterBarLabel(GetVendorsParams getVendorsParams) {
    int appliedFilters = 0;
    String label = '';
    if (getVendorsParams.rate != null) {
      appliedFilters++;
      label = '${getVendorsParams.rate} ' + 'Stars';
    }
    if (getVendorsParams.lon != null) {
      if (appliedFilters == 1) {
        label = '$label, ' + "Near_By";
      } else {
        label = 'Near_By';
      }
      appliedFilters++;
    }
    if (label.isEmpty) return null;
    return label;
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton(
      {Key? key, required this.isSelected, required this.label, this.onTab})
      : super(key: key);
  final bool isSelected;
  final String label;
  final Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab!();
        }
      },
      child: Container(
        width: 1.sw,
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: isSelected
                      ? getBoldStyle(color: ColorManager.primaryColor)
                      : getBoldStyle(color: ColorManager.primaryColor),
                ),
                Visibility(
                  visible: isSelected,
                  child: Icon(
                    Icons.circle,
                    size: 16,
                    color: ColorManager.primaryColor,
                  ),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class SortBottomSheetBody extends StatelessWidget {
  SortBottomSheetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VendorsListBloc vendorsListBloc = context.read<VendorsListBloc>();
    return BlocBuilder<VendorsListBloc, VendorsListState>(
        buildWhen: (prev, current) {
      log("BUILDER 2");
      return true;
    }, builder: (context, state) {
      if (state.screenStates == ScreenStates.success) {
        return SizedBox(
          height: 420,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Sort By',
                      style: getBoldStyle(color: ColorManager.primaryColor),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<VendorsListBloc>().add(ClearSortValue());
                      },
                      child: Icon(
                        Icons.filter_alt_off_outlined,
                        color: ColorManager.primaryColor,
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                FilterButton(
                  label: 'By Visits',
                  isSelected: state.pendingFilters.visits != null,
                  onTab: () {
                    if (vendorsListBloc.pendingFilter.visits != true) {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(visits: true)));
                    } else {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(visits: null)));
                    }
                  },
                ),
                FilterButton(
                  label: 'A - Z',
                  isSelected: state.pendingFilters.sortByName == true,
                  onTab: () {
                    if (vendorsListBloc.pendingFilter.sortByName != true) {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(sortByName: true)));
                    } else {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(sortByName: null)));
                    }
                  },
                ),
                FilterButton(
                  label: 'Z - A',
                  isSelected: state.pendingFilters.sortByName == false,
                  onTab: () {
                    if (vendorsListBloc.pendingFilter.sortByName != false) {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(sortByName: false)));
                    } else {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(sortByName: null)));
                    }
                  },
                ),
                FilterButton(
                  label: 'Oldest',
                  isSelected: state.pendingFilters.recent == false,
                  onTab: () {
                    if (vendorsListBloc.pendingFilter.recent != false) {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(recent: false)));
                    } else {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(recent: null)));
                    }
                  },
                ),
                FilterButton(
                  label: 'Latest',
                  isSelected: state.pendingFilters.recent == true,
                  onTab: () {
                    if (vendorsListBloc.pendingFilter.recent != true) {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(recent: true)));
                    } else {
                      vendorsListBloc.add(SetPendingSortingValue(
                          GetVendorsParams(recent: null)));
                    }
                  },
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    fillColor: ColorManager.softYellow,
                    label: 'Apply',
                    onTap: () {
                      Navigator.of(context).pop();
                      context.read<VendorsListBloc>().add(SetAppliedFilter());
                      vendorsListBloc.add(RefreshVendorsList());
                      // context
                      //     .read<VendorsListBloc>()
                      //     .add(ChangeFilterIndexEvent());
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              50), // Set the border radius to 50 to make it circular
                        ),
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Dismiss',
                              style: getBoldStyle(
                                  color: ColorManager.primaryColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return SizedBox();
    });
  }
}

class FilterBottomSheetBody extends StatelessWidget {
  FilterBottomSheetBody({Key? key}) : super(key: key);
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    VendorsListBloc vendorsListBloc = context.read<VendorsListBloc>();
    return BlocBuilder<VendorsListBloc, VendorsListState>(
        buildWhen: (prev, current) {
      print('BULDING');
      return true;
    }, builder: (context, state) {
      if (state.screenStates == ScreenStates.success) {
        return Container(
          height: 400,
          child: PageView.builder(
            controller: pageController,
            itemCount: 2,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              switch (index) {
                case 1:
                  return FilterByStarsBottomSheetBody(
                    pageController: pageController,
                  );
              }
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Filter By',
                          style: getBoldStyle(color: ColorManager.primaryColor),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            vendorsListBloc.add(ClearFilterValues());
                          },
                          child: Icon(
                            Icons.filter_alt_off_outlined,
                            color: ColorManager.primaryColor,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        pageController.jumpToPage(1);
                      },
                      child: Container(
                        width: 1.sw,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "By_Rate",
                                  style:
                                      vendorsListBloc.pendingFilter.rate != null
                                          ? getBoldStyle(
                                              color: ColorManager.primaryColor)
                                          : getBoldStyle(
                                              color: ColorManager.primaryColor),
                                ),
                                if (vendorsListBloc.pendingFilter.rate != null)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: ColorManager.softYellow,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 2
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 3
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 4
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: state.pendingFilters.rate! >= 5
                                            ? ColorManager.softYellow
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FilterButton(
                      label: 'Near_By',
                      isSelected: state.pendingFilters.lon != null,
                      onTab: () {
                        vendorsListBloc.add(ToggleNearByFilter());
                      },
                    ),
                    FilterButton(
                      label: 'Opening Now',
                      isSelected: state.pendingFilters.isOpen == true,
                      onTab: () {
                        vendorsListBloc.add(ToggleIsOpenFilter());
                        // if (vendorsListBloc.pendingFilter.isOpen != true) {
                        //   vendorsListBloc.add(SetPendingFilteringValue(
                        //       GetVendorsParams(isOpen: true)));
                        // } else {
                        //   vendorsListBloc.add(SetPendingFilteringValue(
                        //       GetVendorsParams(isOpen: false)));
                        // }
                      },
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        fillColor: ColorManager.softYellow,
                        label: 'Apply',
                        onTap: () {
                          Navigator.of(context).pop();
                          vendorsListBloc.add(SetAppliedFilter());
                          vendorsListBloc.add(RefreshVendorsList());
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 64),
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50), // Set the border radius to 50 to make it circular
                            ),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: ColorManager.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Dismiss',
                                  style: getBoldStyle(
                                      color: ColorManager.primaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              // Return different screens based on index
            },
          ),
        );
      }
      return SizedBox();
    });
  }
}

class FilterByStarsBottomSheetBody extends StatelessWidget {
  const FilterByStarsBottomSheetBody({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                  // color: ColorManager.labelGrey,
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter_By_Rate',
                style: getBoldStyle(color: ColorManager.primaryColor),
              ),
              Divider(
                color: Colors.grey,
                height: 3,
              ),
              Column(
                children: [
                  RateStarsRadioButton(
                    rate: 5,
                  ),
                  RateStarsRadioButton(
                    rate: 4,
                  ),
                  RateStarsRadioButton(
                    rate: 3,
                  ),
                  RateStarsRadioButton(
                    rate: 2,
                  ),
                  RateStarsRadioButton(
                    rate: 1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  fillColor: ColorManager.primaryColor,
                  label: 'Apply',
                  onTap: () {
                    pageController.jumpToPage(0);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
                child: SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50), // Set the border radius to 50 to make it circular
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<VendorsListBloc>()
                          .add(SetByRateFilter(null));
                      pageController.jumpToPage(0);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Clear_Rate_Filter',
                            style:
                                getBoldStyle(color: ColorManager.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RateStarsRadioButton extends StatelessWidget {
  const RateStarsRadioButton({
    Key? key,
    required this.rate,
  }) : super(key: key);
  final int rate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<VendorsListBloc>().add(SetByRateFilter(rate));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: context.read<VendorsListBloc>().pendingFilter.rate ==
                            rate
                        ? ColorManager.primaryColor
                        : Colors.grey,
                    width: 2),
              ),
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      context.read<VendorsListBloc>().pendingFilter.rate == rate
                          ? ColorManager.primaryColor
                          : Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: ColorManager.primaryColor,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  color: rate >= 2 ? ColorManager.primaryColor : Colors.grey,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  color: rate >= 3 ? ColorManager.primaryColor : Colors.grey,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  color: rate >= 4 ? ColorManager.primaryColor : Colors.grey,
                  size: 20,
                ),
                Icon(
                  Icons.star,
                  color: rate >= 5 ? ColorManager.primaryColor : Colors.grey,
                  size: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
