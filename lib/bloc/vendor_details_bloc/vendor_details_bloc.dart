
import 'package:absher/bloc/vendor_details_bloc/vendor_details_event.dart';
import 'package:absher/bloc/vendor_details_bloc/vendor_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repository.dart';
class VendorDetailsBloc extends Bloc<VendorDetailsEvent, VendorDetailsState> {
  VendorDetailsBloc() : super(VendorDetailsLoading()) {
    on<VendorDetailsEvent>((event, emit) async {
      if (event is getVendorDetails) {
        emit(VendorDetailsLoading());
        final response = await HomeRepository.getVendorDetails(id: event.id);
        response.fold((l) {
          emit(VendorDetailsError(l));
        }, (r) {
          print("rrrrrrrrrrrrrrrr");
          print(r.name);
          print(r);
          emit(VendorDetailsSuccess(r));
        });
      }
    });
  }
}
