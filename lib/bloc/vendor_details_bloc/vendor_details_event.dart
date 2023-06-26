abstract class VendorDetailsEvent {
  VendorDetailsEvent([List props = const []]) : super();
}

class GetVendorDetails extends VendorDetailsEvent {
  int id;
  GetVendorDetails(this.id);
}

class ChangeDetailsFavoriteStatus extends VendorDetailsEvent {}
