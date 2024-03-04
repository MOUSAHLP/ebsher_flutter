import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/screens/vendors_screen/widgets/search_filter/rate_stars_radio_button.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/custom_button.dart';

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
                AppLocalizations.of(context)!.filterByRate,
                style: getBoldStyle(color: ColorManager.primaryColor),
              ),
              const Divider(
                color: Colors.grey,
                height: 3,
              ),
              const Column(
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
                      side: const BorderSide(
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
                            AppLocalizations.of(context)!.clearRateFilter,
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
