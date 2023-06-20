import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/values_app.dart';
class BuildShimmerWidget extends StatelessWidget {
  const BuildShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  shimmerCircle(),
                  shimmerCircle(),
                  shimmerCircle(),

                ],
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
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
                    width: 350,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                child: GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => shimmerCategory(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget shimmerCircle() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFd3d7de),
      highlightColor: const Color(0xFFe2e4e9),
      child: Card(
        elevation: 0.0,
        color: const Color.fromRGBO(45, 45, 45, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const SizedBox(
          width: 80,
          height: 80,
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
          width: 50,
          height: 100,
        ),
      ),
    );
  }
}
