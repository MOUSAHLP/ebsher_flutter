import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../bloc/search_bloc/search_bloc.dart';
import '../../../../bloc/search_bloc/search_event.dart';
import '../../../../bloc/search_bloc/search_state.dart';
import '../../../../core/app_enums.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../translations.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_app.dart';
import '../../../resources/style_app.dart';
import '../../../resources/values_app.dart';
import '../../../widgets/custom_app_background.dart';
import '../../../widgets/custom_app_bar_screens.dart';
import '../../vendors_screen/widgets/card_random.dart';

class SearchVendor extends StatelessWidget {
  const SearchVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (BuildContext context) => sl<SearchBloc>(),
      child: const SearchVendorBody(),
    );
  }
}

class SearchVendorBody extends StatelessWidget {
  const SearchVendorBody({
    Key? key,
    this.label,
  }) : super(key: key);

  final String? label;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomAppBackGround(
        child: Column(
          children: [
            //
            CustomAppBarScreens(
              title: AppLocalizations.of(context)!.search,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(RadiusApp.r50)),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .add(SearchCategory());
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: ColorManager.primaryColor,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      borderRadius:
                                          const BorderRadiusDirectional.only(
                                              topStart: Radius.circular(20),
                                              bottomStart: Radius.circular(20)),
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: context
                                                .read<SearchBloc>()
                                                .searchController,
                                            minLines: 1,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            onEditingComplete: () {
                                              context
                                                  .read<SearchBloc>()
                                                  .add(SearchCategory());
                                            },
                                            decoration: InputDecoration(
                                              fillColor:
                                                  const Color(0xFFEEF6F6),
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .searchPlaceHolder,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              labelStyle: getRegularStyle(
                                                  color: Colors.white),
                                              hintStyle: getBoldStyle(
                                                color: Colors.grey,
                                              ),
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(28.0)),
                                                borderSide: BorderSide.none,
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(28.0)),
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(28.0)),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<SearchBloc>()
                                      .searchController
                                      .clear();
                                  context
                                      .read<SearchBloc>()
                                      .pendingFilter
                                      .skipCount = 0;
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: ColorManager.primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state.screenStates == ScreenStates.loading &&
                    context.read<SearchBloc>().isFirstLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: ColorManager.whiteColor,
                  ));
                } else if (state.screenStates == ScreenStates.error) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state.screenStates == ScreenStates.init) {
                  return const SizedBox();
                } else {
                  return state.vendorsList.isEmpty
                      ? whenSearchResultEmpty(context)
                      : LazyLoadScrollView(
                          onEndOfPage: () {
                            if (context.read<SearchBloc>().isLast == false) {
                              context
                                  .read<SearchBloc>()
                                  .add(SearchCategoryPage());
                            }
                          },
                          isLoading: !context.read<SearchBloc>().isLast,
                          child: ListView.builder(
                            itemCount: state.vendorsList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CardRandomWidget(
                                    vendor: state.vendorsList[index],
                                    fromSearch: true,
                                  ),
                                  state.screenStates == ScreenStates.loading &&
                                          index == state.vendorsList.length - 1
                                      ? Center(
                                          child: Shimmer.fromColors(
                                            baseColor: const Color(0xFFd3d7de),
                                            highlightColor:
                                                const Color(0xFFe2e4e9),
                                            child: const Card(
                                              elevation: 0.0,
                                              color: Color.fromRGBO(
                                                  45, 45, 45, 1.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                  topStart: Radius.circular(50),
                                                  bottomStart:
                                                      Radius.circular(50),
                                                ),
                                              ),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: SizedBox(
                                                width: 350,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              );
                            },
                          ),
                        );
                }
              }),
            )
          ],
        ),
      ),
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
}
