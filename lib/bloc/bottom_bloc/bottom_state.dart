import '../../models/advertisement_response.dart';
import '../../models/category_response.dart';
import '../../models/search_response.dart';

abstract class BottomState {}
class BottomInit extends BottomState {}

class NewButtom extends BottomState {
  int index;
  NewButtom(this.index);
}
