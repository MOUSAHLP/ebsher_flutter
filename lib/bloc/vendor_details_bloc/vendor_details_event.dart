

abstract class VendorDetailsEvent {
  VendorDetailsEvent([List props = const []]) : super();
}
class getVendorDetails extends VendorDetailsEvent {
  int id;
  getVendorDetails(this.id);
}
