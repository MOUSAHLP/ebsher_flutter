
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_resource/local_resource/data_store.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {

  LanguageBloc() : super(LanguageInit()) {
    on<LanguageEvent>((event, emit) async {
      if (event is NewLanguageChange) {
        DataStore.instance.setLang(event.language);
        emit(NewLanguage(event.language));
      }
    });
  }
}
