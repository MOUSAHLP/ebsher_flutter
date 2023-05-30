import '../../models/vendor_model.dart';

abstract class VendorsListState {}

class VendorsListLoading extends VendorsListState {}

class VendorsListError extends VendorsListState {
  String error;
  VendorsListError(this.error);
}

class VendorsListSuccess extends VendorsListState {
  List<VendorModel> vendorsList;
  VendorsListSuccess(this.vendorsList);
}
