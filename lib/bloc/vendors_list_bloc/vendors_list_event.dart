import 'package:absher/models/sub_category_item_model.dart';

import '../../models/params/get_vendors_params.dart';
import '../../models/vendor_model.dart';

abstract class VendorsListEvent {
  VendorsListEvent([List props = const []]) : super();
}

class GetVendorsList extends VendorsListEvent {
  final int subCategoryId;
   final List<SubCategoryItemModel>? subCategories;
  GetVendorsList(this.subCategoryId,
       this.subCategories
      );
}

class GetVendorsListPagination extends VendorsListEvent {
  final int subCategoryId;
  final List<SubCategoryItemModel>? subCategories;
  GetVendorsListPagination(this.subCategoryId, this.subCategories);
}

class ChangeSelectedSubCategory extends VendorsListEvent {
  final int subCategoryId;

  ChangeSelectedSubCategory(this.subCategoryId);
}

class RefreshVendorsList extends VendorsListEvent {}

class ChangeVendorsListFavoriteStatus extends VendorsListEvent {
  final int vendorId;

  ChangeVendorsListFavoriteStatus(
    this.vendorId,
  );
}

class SetPendingSortingValue extends VendorsListEvent {
  GetVendorsParams getVendorsParams;

  SetPendingSortingValue(this.getVendorsParams);
}

// class SetPendingFilteringValue extends VendorsListEvent {
//   GetVendorsParams getVendorsParams;
//
//   SetPendingFilteringValue(this.getVendorsParams);
// }

class ToggleIsOpenFilter extends VendorsListEvent {}

class ToggleNearByFilter extends VendorsListEvent {}

class SetByRateFilter extends VendorsListEvent {
  int? newRateValue;
  SetByRateFilter(this.newRateValue);
}

class ResetPendingFilterParams extends VendorsListEvent {}

class SetAppliedFilter extends VendorsListEvent {}

class ClearSortValue extends VendorsListEvent {}

class ClearFilterValues extends VendorsListEvent {}

class ChangeStatusList extends VendorsListEvent {
  VendorModel vendorFavorit;
  ChangeStatusList(this.vendorFavorit);
}

class GetCityNameEvent extends VendorsListEvent{

}

class SelectedCityNameEvent extends VendorsListEvent {}

class GetRegionNameEvent extends VendorsListEvent {}

class SelectedRegionNameEvent extends VendorsListEvent {}





