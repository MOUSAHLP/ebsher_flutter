import 'package:absher/bloc/home_bloc/home_event.dart';
import 'package:absher/bloc/home_bloc/home_state.dart';
import 'package:absher/models/story_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/category_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int index = 0;
  List<StoryModelDto>? stories = dummyStories;

  HomeBloc() : super(CategoryLoading()) {
    on<HomeEvent>((event, emit) async {
      // ignore: unnecessary_type_check
      if (event is Home) {
        emit(CategoryLoading());
        final response = await CategoryRepository.getCategory();
        response.fold((l) {
          emit(CategoryError(l));
        }, (r) {
          emit(CategorySuccess(index, r.categories!, r.mainAds!));
        });
      }
      if (event is SetIndex) {
        index = event.indexNew!;
        emit(CategorySuccess(
            event.indexNew!, event.lisCategory!, event.lisAdvertisment!));
      }
    });
  }
}
