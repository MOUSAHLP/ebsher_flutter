import '../../presentation/resources/assets_manager.dart';

String imageTypeName(int? id) {
  switch (id) {
    case TypesPackage.noPackage:
      return ImageManager.bluePackage;
    case TypesPackage.onePackage:
      return ImageManager.sliverDark;
    case TypesPackage.twoPackage:
      return ImageManager.appGolden;
    case TypesPackage.threePackage:
      return ImageManager.sliverLight;
  }
  return ImageManager.bluePackage;
}



class TypesPackage {
  static const int noPackage = 0;
  static const int onePackage = 1;
  static const int twoPackage = 2;
  static const int threePackage = 3;
  static const List<int> typeImageList = [
    noPackage,
    onePackage,
    twoPackage,
    threePackage
  ];
}
