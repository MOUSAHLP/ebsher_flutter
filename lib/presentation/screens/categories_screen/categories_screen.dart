import 'package:absher/bloc/home_bloc/home_bloc.dart';
import 'package:absher/core/localization_string.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_router/app_router.dart';
import '../../../models/category_response.dart';
import '../../resources/font_app.dart';
import '../sub_categories_screen/sub_categories_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Expanded(
                        child: CategoriesStackList(
                      categoriesList: context.read<HomeBloc>().categories ?? [],
                    )),
                  ],
                ),
                Container(
                  height: 130,
                  width: 1.sw,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50)),
                      color: ColorManager.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                        onTap: () {
                          AppRouter.pop(context);
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)!.allCategory,
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: FontSizeApp.s22,
                        ),
                      ),
                      const Icon(
                        Icons.share,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesStackList extends StatelessWidget {
  const CategoriesStackList({Key? key, required this.categoriesList})
      : super(key: key);
  final List<CategoyResponse> categoriesList;
  final double overlap = 154.0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stackLayers =
        List<Widget>.generate(categoriesList.length, (index) {
      return Padding(
        padding: EdgeInsets.fromLTRB(0, index.toDouble() * overlap, 0, 0),
        child: CategoryCover(
          category: categoriesList[index],
        ),
      );
    });
    return SingleChildScrollView(
      child: Stack(
        children: stackLayers.reversed.toList(),
      ),
    );
  }
}

class CategoryCover extends StatelessWidget {
  const CategoryCover({Key? key, required this.category}) : super(key: key);
  final CategoyResponse category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.push(
          context,
          SubCategoriesScreen(
              title: localizationString(context, category.name) ?? "",
              id: category.id!),
        );
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
            child:
    //         Container(
    //             width: 1.sw,
    //             height: 200,
    //           color:Colors.black,
    //             child:Image.asset(
    // ImageManager.fullAppLogo,
    //               color:ColorManager.primaryColor
    // )
    //
    //         )
            CachedImage(
              imageUrl: category.image,
              width: 1.sw,
              height: 1.sw*0.55,
              imageSize: ImageSize.mid,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.softYellow,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedImage(
                        width: 14,
                        height: 14,
                        imageUrl: category.thumbnail,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizationString(context, category.name) ?? '',
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: FontSizeApp.s22,
                      )?.copyWith(height: 1),
                    ),
                    Text(
                      category.vendorsCount ?? "",
                      style: getRegularStyle(
                        color: Colors.white,
                        fontSize: FontSizeApp.s14,
                      )?.copyWith(height: 1),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
