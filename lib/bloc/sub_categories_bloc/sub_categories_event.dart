abstract class SubCategoriesEvent {
  SubCategoriesEvent([List props = const []]) : super();
}
class SubCategories extends SubCategoriesEvent {
  final int  idCategory;

  SubCategories(this.idCategory);
}
