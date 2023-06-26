abstract class LocationEvent {
  LocationEvent([List props = const []]) : super();
}

class CurrentLocation extends LocationEvent {}

class FilterVendors extends LocationEvent {}

class ClickMarker extends LocationEvent {
  int index;
  ClickMarker(this.index);
}

class IndexIncrement extends LocationEvent {}

class IndexDecrement extends LocationEvent {}

class CheckIndex extends LocationEvent {
  int index;
  CheckIndex(
    this.index,
  );
}

class ChangeLocationListFavoriteStatus extends LocationEvent {
  final int vendorId;

  ChangeLocationListFavoriteStatus(
    this.vendorId,
  );
}
