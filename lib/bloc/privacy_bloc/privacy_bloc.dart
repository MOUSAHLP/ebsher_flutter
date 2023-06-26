import 'package:absher/bloc/privacy_bloc/privacy_event.dart';
import 'package:absher/bloc/privacy_bloc/privacy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/about&privacy.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  String content = '';
  PrivacyBloc() : super(PrivacyLoading()) {
    on<PrivacyEvent>((event, emit) async {
      if (event is GetPrivacy) {
        emit(PrivacyLoading());
        final response = await AboutAndPrivacyRepository.getPrivacy();
        response.fold((l) {
          emit(PrivacyError(l));
        }, (r) {
          content = r;
          emit(PrivacySuccess(r));
        });
      }
    });
  }
}
