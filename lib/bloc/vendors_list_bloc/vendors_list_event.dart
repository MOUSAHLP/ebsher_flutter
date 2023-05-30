abstract class VendorsListEvent {
  VendorsListEvent([List props = const []]) : super();
}

class GetVendorsList extends VendorsListEvent {
  final int idCategory;

  GetVendorsList(this.idCategory);
}
