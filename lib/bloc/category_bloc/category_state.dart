import '../../models/advertisement_response.dart';
import '../../models/category_response.dart';

abstract class CategoryState {}



class CategoryLoading extends CategoryState {}
class NewIndex extends CategoryState {}

class CategoryError extends CategoryState {
  String error;

  CategoryError(this.error);
}

class CategorySuccess extends CategoryState
{
  int index;
  List<CategoyResponse> lisCategory;
  List<AdvertisementsResponse> lisAdvertisment;
  CategorySuccess(this.index,this.lisCategory,this.lisAdvertisment);

}
