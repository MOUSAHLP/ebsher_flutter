import 'package:absher/bloc/exhibitions_bloc/exhibitions_bloc.dart';
import 'package:absher/presentation/screens/exhibitions_screen/widgets/build_shimmer_exhibitions.dart';
import 'package:absher/presentation/screens/exhibitions_screen/widgets/info_details.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:absher/presentation/widgets/custom_app_bar_screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/exhibitions_bloc/exhibitions_event.dart';
import '../../../bloc/exhibitions_bloc/exhibitions_state.dart';
import '../../../core/app_router/app_router.dart';
import '../../../core/services/services_locator.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/accessories/cached_image.dart';
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

class ExhibitionsBody extends StatefulWidget {
  const ExhibitionsBody({
    super.key,
  });

  @override
  State<ExhibitionsBody> createState() => _ExhibitionsBodyState();
}

class _ExhibitionsBodyState extends State<ExhibitionsBody> {
  late Map<int, bool> isOpenMap;

  @override
  void initState() {
    super.initState();
    isOpenMap = {};
  }
  @override
  Widget build(BuildContext context) {
    var size = (1.sw - 40) * 98;
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
                                isOpenMap.putIfAbsent(index, () => false);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            AppRouter.push(
                                              context,
                                              VendorsExhibitionsScreen(
                                                title: state.exhibitionsList[index]
                                                    .name ??
                                                    '',
                                                exhibitionsId:
                                                state.exhibitionsList[index].id!,
                                                image: state.exhibitionsList[index]
                                                    .image ??
                                                    '',
                                              ),
                                            );
                                  },
                                          child: Container(
                                            width: size,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white.withOpacity(0.5)
                                            ),
                                            // height: size / 338,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedImage(
                                                imageUrl: state
                                                        .exhibitionsList[index]
                                                        .image ??
                                                    "",
                                                fit: BoxFit.cover,
                                                height: size / 270,
                                                imageSize: ImageSize.mid,
                                              ),
                                            ),
                                          ),
                                        ),
                                  isOpenMap[index]!?  const SizedBox(height:10,):const SizedBox(height: 30),
                                        AnimatedCrossFade(
                                            firstChild: InkWell(
                                              onTap: (){
                                                setState(() {
                                                  isOpenMap[index] = !isOpenMap[index]!;
                                                });
                                              },
                                              child: Image.asset(
                                                  ImageManager.arrow),
                                            ),
                                            secondChild: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  InfoDetails(label: AppLocalizations.of(context)!.exhibition_name,value:state
                                                      .exhibitionsList[index]
                                                      .name ??
                                                      "" ),
                                                  InfoDetails(label: AppLocalizations.of(context)!.from_date,value:state
                                                      .exhibitionsList[index]
                                                      .start_date ??
                                                      "" ),
                                                  InfoDetails(label: AppLocalizations.of(context)!.to_date,value:state
                                                      .exhibitionsList[index]
                                                      .end_date ??
                                                      "" ),
                                                  InfoDetails(label: AppLocalizations.of(context)!.organizing_company,value:state
                                                      .exhibitionsList[index]
                                                      .Organizing_company ??
                                                      "" ),
                                                  InfoDetails(label: AppLocalizations.of(context)!.place,value:state
                                                      .exhibitionsList[index]
                                                      .place ??
                                                      "" ),
                                                  InfoDetails(label: AppLocalizations.of(context)!.visiting_times,value:state
                                                      .exhibitionsList[index]
                                                      .Visit_times ??
                                                      "" ),
                                                  const SizedBox(height: 10,),
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        isOpenMap[index] = !isOpenMap[index]!;
                                                      });
                                                    },
                                                    child: Image.asset(
                                                        ImageManager.arrowUp),
                                                  )],
                                              ),
                                            ),
                                            firstCurve: Curves.linear,
                                            secondCurve: Curves.linear,
                                            crossFadeState:  isOpenMap[index]!
                                                ? CrossFadeState.showSecond
                                                : CrossFadeState.showFirst,
                                            duration: const Duration(
                                                milliseconds: 250)),
                                        const SizedBox(height: 10,),
                                      ],
                                    ),
                                  ),
                                );
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
