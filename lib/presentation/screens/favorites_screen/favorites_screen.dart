import 'package:absher/bloc/favorites_list_bloc/favorites_list_event.dart';
import 'package:absher/bloc/favorites_list_bloc/favorites_list_state.dart';
import 'package:absher/presentation/screens/favorites_screen/widgets/build_shimmer_favorites.dart';
import 'package:absher/presentation/screens/favorites_screen/widgets/card_favorite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/favorites_list_bloc/favorites_list_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoritesScreenBody();

  }
}

class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FavoritesListBloc, FavoritesListState>(
        bloc: sl<FavoritesListBloc>()..add(GetFavoritesList()),
      builder: (context, state) {
        if (state is FavoritesListLoading) {
      return const BuildShimmerFavorites();
        } else if (state is FavoritesListError) {
      return CustomErrorScreen(
        onTap: () {
          sl<FavoritesListBloc>().add(GetFavoritesList());
        },
      );
        } else if (state is FavoritesListSuccess) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: state.vendorsList.isNotEmpty
            ? SingleChildScrollView(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (over) {
                  over.disallowIndicator();
                  return true;
                },
                child: RefreshIndicator(
                    onRefresh: () async {
                      sl<FavoritesListBloc>().add(GetFavoritesList());
                    },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        GridView.builder(
//                        physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.vendorsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CardFavorite(
                              vendorModel: state.vendorsList[index],
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 270,
                          ),
                        )
                      ],
                    ),
                ),
              ),
            )
            : const Center(child: CustomNoDataScreen()),
      );
        } else {
      return const Text("");
        }
      }),
    );
  }
}
