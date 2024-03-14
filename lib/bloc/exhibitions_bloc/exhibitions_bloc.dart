

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/exhibitions_repository.dart';
import 'exhibitions_event.dart';
import 'exhibitions_state.dart';

class ExhibitionsBloc extends Bloc<ExhibitionsEvent, ExhibitionsState> {
  ExhibitionsBloc() : super(ExhibitionsLoading()) {
    on<ExhibitionsEvent>((event, emit) async {
      if (event is GetExhibitions) {
        emit(ExhibitionsLoading());
        final response =
            await ExhibitionsRepository.getExhibitions();
        response.fold((l) {
          emit(ExhibitionsError(l));
        }, (r) {
          emit(ExhibitionsSuccess(r??[]));
        });
      }
    });
  }
}
