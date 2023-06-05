import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../resources/values_app.dart';

class BuildShimmerFavorites extends StatelessWidget {
  const BuildShimmerFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right:8.0, top: 10),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount:4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: const Color(0xFFd3d7de),
                    highlightColor: const Color(0xFFe2e4e9),
                    child: const Card(
                      elevation: 0.0,
                      color: Color.fromRGBO(45, 45, 45, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: SizedBox(
                        width: 350,
                        height: 100,
                      ),
                    ),
                  );
                },
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerCategory() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFd3d7de),
      highlightColor: const Color(0xFFe2e4e9),
      child: const Card(
        elevation: 0.0,
        color: Color.fromRGBO(45, 45, 45, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: 300,
          height: 50,
        ),
      ),
    );
  }
}
