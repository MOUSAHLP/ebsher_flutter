import 'package:absher/bloc/exhibitions_bloc/exhibitions_bloc.dart';
import 'package:absher/presentation/screens/exhibitions_screen/widgets/build_shimmer_exhibitions.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:absher/presentation/screens/sub_categories_screen/widgets/card_sub_category.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/exhibitions_bloc/exhibitions_event.dart';
import '../../../bloc/exhibitions_bloc/exhibitions_state.dart';
import '../../../core/app_router/app_router.dart';
import '../../../core/localization_string.dart';
import '../../../core/services/services_locator.dart';

import '../../widgets/custom_app_background.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_no_data_screen.dart';
import '../vendors_exhibitions_screen/vendors_exhibitions_screen.dart';


class ExhibitionsScreen extends StatelessWidget {


  const ExhibitionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExhibitionsBloc>(
        create: (BuildContext context) =>
        sl<ExhibitionsBloc>()..add(GetExhibitions()),
        child: const ExhibitionsBody());
  }
}

class ExhibitionsBody extends StatelessWidget {


  const ExhibitionsBody({super.key, });

  @override
  Widget build(BuildContext context) {
    return CustomAppBackGround(
        child: SafeArea(
            child: Stack(children: [
              BlocBuilder<ExhibitionsBloc, ExhibitionsState>(builder: (context, state) {
                if (state is ExhibitionsLoading) {
                  return const BuildShimmerExhibitions();
                } else if (state is ExhibitionsError) {
                  return CustomErrorScreen(
                    onTap: () {
                      context.read<ExhibitionsBloc>().add(GetExhibitions());
                    },
                  );
                } else if (state is ExhibitionsSuccess) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ExhibitionsBloc>().add(GetExhibitions());
                    },
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (over) {
                        over.disallowIndicator();
                        return true;
                      },
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Expanded(
                            child: SizedBox(
                              child: state.exhibitionsList.isNotEmpty
                                  ? ListView.builder(
                                itemCount: state.exhibitionsList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        AppRouter.push(
                                          context,
                                          VendorsExhibitionsScreen(
                                            title: state
                                                    .exhibitionsList[index].name??'',
                                            exhibitionsId:
                                            state
                                                .exhibitionsList[index].id!, image:state
                                              .exhibitionsList[index].image??'',

                                          ),
                                        );
                                      },
                                      child: CardSubCategory(
                                        title:
                                            state.exhibitionsList[index].name??"",
                                        image: state.exhibitionsList[index].image ??
                                            "",
                                      ));
                                },
                              )
                                  : const Center(child: CustomNoDataScreen()),
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text("");
                }
              }),
              Stack(
                children: [
                  CustomAppBarScreens(
                    title: AppLocalizations.of(context)!.exhibitions,
                  )
                ],
              ),
            ])));
  }
}
