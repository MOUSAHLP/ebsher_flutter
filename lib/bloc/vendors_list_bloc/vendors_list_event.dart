import '../../models/params/get_vendors_params.dart';

abstract class VendorsListEvent {
  VendorsListEvent([List props = const []]) : super();
}

class GetVendorsList extends VendorsListEvent {
  final int idCategory;

  GetVendorsList(this.idCategory);
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
