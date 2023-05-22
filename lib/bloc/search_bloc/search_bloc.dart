import 'package:absher/bloc/search_bloc/search_event.dart';
import 'package:absher/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/category_repository.dart';

class SearchBloc extends Bloc <SearchEvent,SearchState>{
  SearchBloc():super(
      SearchCategoryLoading()){
    on<SearchEvent>((event, emit) async {
      if(event is SearchCategory){
        emit(SearchCategoryLoading());
        final response = await CategoryRepository.getSearchCategory(text:event.textSearch);
        response.fold((l) {
          emit(SearchCategoryError(l));
        }, (r) {
          emit(SearchCategorySuccess(r));
        });
      }
  });

}}