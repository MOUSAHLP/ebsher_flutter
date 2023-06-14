
import 'package:absher/bloc/sub_category_bloc/sub_category_event.dart';
import 'package:absher/bloc/sub_category_bloc/sub_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repository.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  SubCategoryBloc() : super(SubCategoryLoading()) {
    on<SubCategoryEvent>((event, emit) async {
      if (event is GetSubCategory) {
        emit(SubCategoryLoading());
        final response =
            await HomeRepository.getSubCategory(categoryId: event.idCategory);
        response.fold((l) {
          emit(SubCategoryError(l));
        }, (r) {
          emit(SubCategorySuccess(r.subCategories!,r.mainAds!));
        });
      }
    });
  }
}
