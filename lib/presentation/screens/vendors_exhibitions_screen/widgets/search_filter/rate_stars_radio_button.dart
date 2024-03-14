import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RateStarsRadioButton extends StatelessWidget {
  const RateStarsRadioButton({
    Key? key,
    required this.rate,
  }) : super(key: key);
  final int rate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorsListBloc, VendorsListState>(
        builder: (context, state) {
      return GestureDetector(
        onTap: () {
          context.read<VendorsListBloc>().add(SetByRateFilter(rate));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: state.pendingFilters.rate == rate
                          ? ColorManager.primaryColor
                          : Colors.grey,
                      width: 2),
                ),
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.pendingFilters.rate == rate
                        ? ColorManager.primaryColor
                        : Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Row(
                children: [
                  const Icon(
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
    });
  }
}
