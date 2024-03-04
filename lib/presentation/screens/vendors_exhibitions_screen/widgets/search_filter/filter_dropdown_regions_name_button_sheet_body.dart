import 'package:absher/bloc/vendors_list_bloc/vendors_list_bloc.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/models/city_name_model.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDropDownRegions extends StatelessWidget {
  final Function onChanged;
  final CityNameModel cityNameModel;
  const FilterDropDownRegions({
    super.key,
    required this.onChanged,
    required this.cityNameModel,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<VendorsListBloc, VendorsListState>(
        builder: (context, state) {
      print('============== FilterDropDownRegions ==============');
      print(state.regionsName!.data);
      return SizedBox(
        height: 4.h,
        width: 1.sw,
        child: DropdownButton(
          enableFeedback: true,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          value: state.selectedTheRegionsName,
          items: cityNameModel.data.map((item) {
            return DropdownMenuItem(
              value: item.name ,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: (value) => onChanged(value),
          isExpanded: true,
          //make true to take width of parent widget
          underline: Container(),
          //empty line
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 14,
            color: ColorManager.primaryColor,
          ),
          dropdownColor: ColorManager.whiteColor,
          iconEnabledColor: ColorManager.primaryColor,
          iconSize: 30, //Icon color
        ),
      );
    });
  }
}
