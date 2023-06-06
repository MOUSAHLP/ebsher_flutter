import 'package:absher/bloc/home_bloc/home_bloc.dart';
import 'package:absher/core/localization_string.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:absher/presentation/resources/color_manager.dart';
import 'package:absher/presentation/resources/style_app.dart';
import 'package:absher/presentation/widgets/accessories/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_router/app_router.dart';
import '../../../models/category_response.dart';
import '../../resources/font_app.dart';
import '../vendors_screen/vendors_screen.dart';

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
                    SizedBox(
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
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50)),
                      color: ColorManager.primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'كافة التصنيفات',
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: FontSizeApp.s22,
                        ),
                      ),
                      Icon(
                        Icons.share,
                        color: Colors.white,
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
          VendorsScreen(
              title: LocalixationString(context, category.name) ?? "",
              categoryId: category.id!),
        );
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),

            // decoration:
            //     const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Image.asset(
              ImageManager.categoryCoverTest,
              width: 1.sw,
              height: 200,
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
                    padding: const EdgeInsets.all(4.0),
                    child: CachedImage(
                      width: 14,
                      imageUrl: category.logo,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalixationString(context, category.name) ?? '',
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: FontSizeApp.s22,
                      )?.copyWith(height: 1),
                    ),
                    Text(
                      '12 عنصر',
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
