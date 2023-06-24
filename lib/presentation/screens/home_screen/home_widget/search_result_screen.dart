import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/resources/values_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/search_bloc/search_bloc.dart';
import '../../../../bloc/search_bloc/search_event.dart';
import '../../../../bloc/search_bloc/search_state.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../models/category_response.dart';
import '../../../../translations.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_app.dart';
import '../../../widgets/custom_app_background.dart';
import 'package:lottie/lottie.dart';

import '../../vendors_screen/widgets/card_random.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<CategoyResponse> listCategory = [];

  CustomSearchDelegate(this.listCategory);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: FontSizeApp.s20, color: Colors.white),
      ),
      appBarTheme:
          const AppBarTheme(backgroundColor: Color(0xFF257679), elevation: 0),
      inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle:
              getRegularStyle(color: Colors.white, fontSize: FontSizeApp.s18)),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: ColorManager.whiteColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget whenSearchResultEmpty(BuildContext context) {
    return CustomAppBackGround(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: PaddingApp.p30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Lottie.asset(IconsManager.iconNoResult),
                    Text(
                      AppLocalizations.of(context)!.noResult,
                      style: getBoldStyle(
                          color: Colors.white, fontSize: FontSizeApp.s18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
        bloc: sl<SearchBloc>()..add(SearchCategory(query)),
        builder: (context, state) {
          if (state is SearchCategoryLoading) {
            return const CustomAppBackGround(
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Color(0xFF257679),
                color: ColorManager.whiteColor,
              )),
            );
          }
          if (state is SearchCategoryError) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is SearchCategorySuccess) {
            return state.listSearch.isEmpty
                ? whenSearchResultEmpty(context)
                : CustomAppBackGround(
                    child: ListView.builder(
                      itemCount: state.listSearch.length,
                      itemBuilder: (context, index) {
                        return CardRandomWidget(
                          vendor: state.listSearch[index],
                          fromSearch: true,
                        );
                      },
                    ),
                  );
          } else {
            return const Text("");
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CustomAppBackGround(child: Text(""));
  }
}
