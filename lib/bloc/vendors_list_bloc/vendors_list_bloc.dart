import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:absher/data/repos/favorite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repository.dart';
import '../../models/vendor_model.dart';

class VendorsListBloc extends Bloc<VendorsListEvent, VendorsListState> {
  VendorsListBloc() : super(VendorsListLoading()) {
    List<VendorModel> vendorsList = [];
    on<VendorsListEvent>((event, emit) async {
      if (event is GetVendorsList) {
        emit(VendorsListLoading());
        final response =
            await HomeRepository.getVendorsList(categoryId: event.idCategory);
        response.fold((l) {
          emit(VendorsListError(l));
        }, (r) {
          vendorsList = [...r];
          emit(VendorsListSuccess(vendorsList));
        });
      }
      if (event is ChangeVendorsListFavoriteStatus) {
        int targetedIndex =
            vendorsList.indexWhere((element) => element.id == event.vendorId);
        if (vendorsList[targetedIndex].favoriteStatus) {
          vendorsList[targetedIndex].favoriteStatus = false;
          emit(VendorsListSuccess(vendorsList));
          final response =
              await FavoriteRepository.removeFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = true;
            emit(VendorsListSuccess(vendorsList));
          }, (r) {});
        } else {
          vendorsList[targetedIndex].favoriteStatus = true;
          emit(VendorsListSuccess(vendorsList));
          final response = await FavoriteRepository.addFavorite(event.vendorId);
          response.fold((l) {
            vendorsList[targetedIndex].favoriteStatus = false;
            emit(VendorsListSuccess(vendorsList));
          }, (r) {});
        }
      }
    });
  }
}
