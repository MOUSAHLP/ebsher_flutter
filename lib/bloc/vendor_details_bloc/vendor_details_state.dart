
import '../../models/vendor_model.dart';
abstract class VendorDetailsState {}

class VendorDetailsLoading extends VendorDetailsState {}

class VendorDetailsError extends VendorDetailsState {
  String error;
  VendorDetailsError(this.error);
}
class VendorDetailsSuccess extends VendorDetailsState {
  VendorModel vendorModel;
  VendorDetailsSuccess(this.vendorModel,);
}
class ChangeState extends VendorDetailsState{}
