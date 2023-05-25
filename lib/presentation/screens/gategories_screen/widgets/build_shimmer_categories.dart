import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../resources/values_app.dart';
class BuildShimmerGategories extends StatelessWidget {
  const BuildShimmerGategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              shimmerCategory(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Shimmer.fromColors(
                    baseColor: const Color(0xFFd3d7de),
                    highlightColor: const Color(0xFFe2e4e9),
                    child: const Card(
                      elevation: 0.0,
                      color: Color.fromRGBO(45, 45, 45, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd:
                          Radius.circular(50),
                          bottomEnd:  Radius.circular(50),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: SizedBox(
                        width: 350,
                        height: 100,
                      ),
                    ),
                  ),
                ),
              )
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