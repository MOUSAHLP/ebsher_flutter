
import 'package:absher/bloc/sub_categories_bloc/sub_categories_event.dart';
import 'package:absher/bloc/sub_categories_bloc/sub_categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/category_repository.dart';

class SubCategoriesBloc extends Bloc <SubCategoriesEvent,SubCategoriesState>{

  SubCategoriesBloc():super(
      SubCategoriesLoading()) {
    on<SubCategoriesEvent>((event, emit) async {
      if (event is SubCategories) {
        emit(SubCategoriesLoading());
        final response = await CategoryRepository.getSubCategories(idCategory: event.idCategory);
        response.fold((l) {
          emit(SubCategoriesError(l));
        }, (r) {
          emit(SubCategoriesSuccess(r));
        });}
    }
    );}
}