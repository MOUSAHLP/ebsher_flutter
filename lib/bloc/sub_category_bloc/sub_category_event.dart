abstract class SubCategoryEvent {
  SubCategoryEvent([List props = const []]) : super();
}

class GetSubCategory extends SubCategoryEvent {
  final int idCategory;

  GetSubCategory(this.idCategory);
}
