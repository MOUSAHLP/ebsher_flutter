import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/category_response.dart';

abstract class CategoryEvent {
  CategoryEvent([List props = const []]) : super();
}
class Category extends CategoryEvent {
}

class SetIndex extends CategoryEvent {
  final int? indexNew;
  List<CategoyResponse>? lisCategory;
  List<AdvertisementsResponse>? lisAdvertisment;
  SetIndex({ this.indexNew,this.lisCategory,this.lisAdvertisment}) : super([indexNew]);

}
