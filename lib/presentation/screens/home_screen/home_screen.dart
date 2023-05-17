import '../../resources/values_app.dart';
import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/style_app.dart';
import '../../resources/color_manager.dart';
import 'home_widget/build_search_widget.dart';
import 'home_widget/build_store_widget.dart';
// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {

  List image = [
    ImageManager.test1,
    ImageManager.test1,
    ImageManager.test1,
  ];

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: SizeApp.s23),
            const BuildStoreWidget(),
            const SizedBox(height: SizeApp.s23),
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
//                  autoPlay: true,
                  height: SizeApp.s140,
                  onPageChanged: (index, reason) {}),
              items: image.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: SizeApp.s16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(RadiusApp.r27),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(RadiusApp.r27),
                            child: Image.asset(
                              i,
                              fit: BoxFit.fill,
                            )));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    height: SizeApp.s14,
                    width:  SizeApp.s14,
                    margin: const EdgeInsets.all(PaddingApp.p5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )
              ],
            ),
            const SizedBox(height:SizeApp.s16),
            const BuildSearchWidget(),
            const SizedBox(height:SizeApp.s16),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal:SizeApp.s16),
              child: GridView.builder(
                physics:const NeverScrollableScrollPhysics() ,
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) =>Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: PaddingApp.p14,vertical: PaddingApp.p8),
                  child: Container(
                    decoration: BoxDecoration(
                        color:index%2==0? ColorManager.lightYellowColor: ColorManager.lightBlueColor,
                        borderRadius: BorderRadius.circular(RadiusApp.r8)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(IconsManager.iconDoctor,height: SizeApp.s56,width:SizeApp.s56),
                        const SizedBox(height: 2),
                        Text("أطباء",style: getBoldStyle(color: ColorManager.whiteColor,fontSize: 14),)
                      ],
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
