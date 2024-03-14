import 'package:absher/models/sub_category_item_model.dart';

import '../../models/params/get_vendors_params.dart';
import '../../models/vendor_model.dart';

abstract class VendorsExhibitionsEvent {
  VendorsExhibitionsEvent([List props = const []]) : super();
}

class GetVendorsList extends VendorsExhibitionsEvent {
  final int subCategoryId;

  GetVendorsList(this.subCategoryId,

      );
}

class GetVendorsListPagination extends VendorsExhibitionsEvent {
  final int subCategoryId;
  final List<SubCategoryItemModel>? subCategories;
  GetVendorsListPagination(this.subCategoryId, this.subCategories);
}

class ChangeSelectedSubCategory extends VendorsExhibitionsEvent {
  final int subCategoryId;

  ChangeSelectedSubCategory(this.subCategoryId);
}

class RefreshVendorsList extends VendorsExhibitionsEvent {}

class ChangeVendorsListFavoriteStatus extends VendorsExhibitionsEvent {
  final int vendorId;

  ChangeVendorsListFavoriteStatus(
    this.vendorId,
  );
}

class SetPendingSortingValue extends VendorsExhibitionsEvent {
  GetVendorsParams getVendorsParams;

  SetPendingSortingValue(this.getVendorsParams);
}

// class SetPendingFilteringValue extends VendorsListEvent {
//   GetVendorsParams getVendorsParams;
//
//   SetPendingFilteringValue(this.getVendorsParams);
// }

class ToggleIsOpenFilter extends VendorsExhibitionsEvent {}

class ToggleNearByFilter extends VendorsExhibitionsEvent {}

class SetByRateFilter extends VendorsExhibitionsEvent {
  int? newRateValue;
  SetByRateFilter(this.newRateValue);
}

class ResetPendingFilterParams extends VendorsExhibitionsEvent {}

class SetAppliedFilter extends VendorsExhibitionsEvent {}

class ClearSortValue extends VendorsExhibitionsEvent {}

class ClearFilterValues extends VendorsExhibitionsEvent {}

class ChangeStatusList extends VendorsExhibitionsEvent {
  VendorModel vendorFavorit;
  ChangeStatusList(this.vendorFavorit);
}

class GetCityNameEvent extends VendorsExhibitionsEvent{

}

class SelectedCityNameEvent extends VendorsExhibitionsEvent {}

class GetRegionNameEvent extends VendorsExhibitionsEvent {}

class SelectedRegionNameEvent extends VendorsExhibitionsEvent {}





