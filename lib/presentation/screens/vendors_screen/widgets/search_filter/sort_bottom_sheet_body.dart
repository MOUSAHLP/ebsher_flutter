
import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/core/app_enums.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/filter_button.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/custom_button.dart';

class SortBottomSheetBody extends StatelessWidget {
  const SortBottomSheetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VendorsListBloc vendorsListBloc = context.read<VendorsListBloc>();
    return BlocBuilder<VendorsListBloc, VendorsListState>(
        builder: (context, state) {
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
                      AppLocalizations.of(context)!.sortBy,
                      style: getBoldStyle(color: ColorManager.primaryColor),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<VendorsListBloc>().add(ClearSortValue());
                      },
                      child: const Icon(
                        Icons.filter_alt_off_outlined,
                        color: ColorManager.primaryColor,
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                FilterButton(
                  label: AppLocalizations.of(context)!.byVisits,
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
                  label: AppLocalizations.of(context)!.az,
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
                  label: AppLocalizations.of(context)!.za,
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
                  label: AppLocalizations.of(context)!.oldest,
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
                  label: AppLocalizations.of(context)!.latest,
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    fillColor: ColorManager.softYellow,
                    label: AppLocalizations.of(context)!.apply,
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
                        side: const BorderSide(
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
                              AppLocalizations.of(context)!.close,
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
      return const SizedBox();
    });
  }
}
