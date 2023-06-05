
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_event.dart';
import 'bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  int index = 0;
  BottomBloc() : super(NewButtom(0)) {
    on<BottomEvent>((event, emit) async {
      if (event is NewBottomChange) {
        index = event.index;
        emit(NewButtom(index));
      }
    });
  }
}
