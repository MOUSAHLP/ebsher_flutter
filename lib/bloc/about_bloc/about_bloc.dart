
import 'package:absher/bloc/about_bloc/about_event.dart';
import 'package:absher/bloc/about_bloc/about_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/about&privacy.dart';
import '../../data/repos/home_repository.dart';
class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutLoading()) {
    on<AboutEvent>((event, emit) async {
      if (event is getAbout) {
        emit(AboutLoading());
        final response = await AboutAndPrivacyRepository.getAbout();
        response.fold((l) {
          emit(AboutError(l));
        }, (r) {
          emit(AboutSuccess(r));
        });
      }
    });
  }
}
