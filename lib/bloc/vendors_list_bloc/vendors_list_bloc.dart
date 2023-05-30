import 'package:absher/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:absher/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repository.dart';

class VendorsListBloc extends Bloc<VendorsListEvent, VendorsListState> {
  VendorsListBloc() : super(VendorsListLoading()) {
    on<VendorsListEvent>((event, emit) async {
      if (event is GetVendorsList) {
        emit(VendorsListLoading());
        final response =
            await HomeRepository.getVendorsList(categoryId: event.idCategory);
        response.fold((l) {
          emit(VendorsListError(l));
        }, (r) {
          emit(VendorsListSuccess(r));
        });
      }
    });
  }
}
