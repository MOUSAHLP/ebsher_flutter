import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/models/params/get_vendors_params.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/filter_bottom_sheet_body.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/sort_bottom_sheet_body.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(56),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext builderContext) {
                    return BlocProvider.value(
                        value: BlocProvider.of<VendorsListBloc>(context),
                        child: const SortBottomSheetBody());
                  });
            },
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
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
                        const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.compare_arrows_rounded,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            sortBarLabel(context,
                                context.read<VendorsListBloc>().appliedFilter),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<VendorsListBloc>().add(ResetPendingFilterParams());
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
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
                  padding: const EdgeInsets.only(left: 0, right: 0),
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
                                filterBarLabel(
                                    context,
                                    context
                                        .read<VendorsListBloc>()
                                        .appliedFilter),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getBoldStyle(color: Colors.black),
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

  String sortBarLabel(BuildContext context, GetVendorsParams getVendorsParams) {
    if (getVendorsParams.visits != null) {
      return AppLocalizations.of(context)!.byVisits;
    }
    if (getVendorsParams.recent == true) {
      return AppLocalizations.of(context)!.latest;
    }
    if (getVendorsParams.recent == false) {
      return AppLocalizations.of(context)!.oldest;
    }
    if (getVendorsParams.sortByName == true) {
      return AppLocalizations.of(context)!.az;
    }
    if (getVendorsParams.sortByName == false) {
      return AppLocalizations.of(context)!.za;
    }
    return AppLocalizations.of(context)!.sortBy;
  }

  String filterBarLabel(
      BuildContext context, GetVendorsParams getVendorsParams) {
    int appliedFilters = 0;
    String label = '';
    if (getVendorsParams.rate != null) {
      appliedFilters++;
      label = AppLocalizations.of(context)!.starsCount(getVendorsParams.rate!);
    }
    if (getVendorsParams.lon != null) {
      if (appliedFilters >= 1) {
        label = '$label, ${AppLocalizations.of(context)!.nearby}';
      } else {
        label = AppLocalizations.of(context)!.nearby;
      }
      appliedFilters++;
    }
    if (getVendorsParams.isOpen == true) {
      if (appliedFilters >= 1) {
        label = '$label, ${AppLocalizations.of(context)!.isOpen}';
      } else {
        label = AppLocalizations.of(context)!.isOpen;
      }
      appliedFilters++;
    }
    if (label.isEmpty) return AppLocalizations.of(context)!.addNewFilters;
    return label;
  }
}
