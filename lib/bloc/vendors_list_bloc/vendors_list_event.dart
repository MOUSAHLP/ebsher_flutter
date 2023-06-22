abstract class VendorsListEvent {
  VendorsListEvent([List props = const []]) : super();
}

class GetVendorsList extends VendorsListEvent {
  final int idCategory;

  GetVendorsList(this.idCategory);
}

class ChangeVendorsListFavoriteStatus extends VendorsListEvent {
  final int vendorId;

  ChangeVendorsListFavoriteStatus(
    this.vendorId,
  );
}
