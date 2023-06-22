import 'package:absher/bloc/vendor_details_bloc/vendor_details_event.dart';
import 'package:absher/bloc/vendor_details_bloc/vendor_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/favorite_repository.dart';
import '../../data/repos/home_repository.dart';
import '../../models/vendor_model.dart';

class VendorDetailsBloc extends Bloc<VendorDetailsEvent, VendorDetailsState> {
  VendorModel? vendor;

  VendorDetailsBloc() : super(VendorDetailsLoading()) {
    on<VendorDetailsEvent>((event, emit) async {
      if (event is getVendorDetails) {
        emit(VendorDetailsLoading());
        final response = await HomeRepository.getVendorDetails(id: event.id);
        response.fold((l) {
          emit(VendorDetailsError(l));
        }, (r) {
          vendor = r;
          emit(VendorDetailsSuccess(vendor!));
        });
      }

      if (event is ChangeDetailsFavoriteStatus) {
        if (vendor!.favoriteStatus) {
          vendor!.favoriteStatus = false;
          emit(VendorDetailsSuccess(vendor!));
          final response = await FavoriteRepository.removeFavorite(vendor!.id!);
          response.fold((l) {
            vendor!.favoriteStatus = true;
            emit(VendorDetailsSuccess(vendor!));
          }, (r) {});
        } else {
          vendor!.favoriteStatus = true;
          emit(VendorDetailsSuccess(vendor!));
          final response = await FavoriteRepository.addFavorite(vendor!.id!);
          response.fold((l) {
            vendor!.favoriteStatus = false;
            emit(VendorDetailsSuccess(vendor!));
          }, (r) {});
        }
      }
    });
  }
}
