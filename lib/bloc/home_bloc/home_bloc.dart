import 'package:absher/bloc/home_bloc/home_event.dart';
import 'package:absher/bloc/home_bloc/home_state.dart';
import 'package:absher/models/story_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repository.dart';
import '../../models/category_response.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int index = 0;
  List<StoryModelDto>? stories = [];
  List<CategoyResponse>? categories = [];
  bool gotHome=false;

  HomeBloc() : super(CategoryLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is Home) {
        if(gotHome)return;
        emit(CategoryLoading());
        final response = await HomeRepository.getHomeData();
        response.fold((l) {
          emit(CategoryError(l));
        }, (r) {
          categories = r.categories ?? [];
          stories = r.story ?? [];
          gotHome=true;
          emit(CategorySuccess(
              index, r.categories ?? [], r.mainAds ?? [], r.story ?? []));
        });
      }
      if(event is ChangeSeeStory)
        {
          for(int i=0;i<event.listIndex.length;i++){
            if(stories!.any((element) => element.id==event.listIndex[i])){
              var matchingIndex = stories!.indexWhere((element) => element.id == event.listIndex[i]);
              stories![matchingIndex].stories![0].seen=1;
            }
          }
          emit(CategorySuccess(
              index, categories??[],  [], stories?? []));
        }
    });
  }
}
