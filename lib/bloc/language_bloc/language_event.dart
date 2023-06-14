import 'package:absher/models/advertisement_response.dart';
import 'package:absher/models/category_response.dart';

abstract class LanguageEvent {
  LanguageEvent([List props = const []]) : super();
}

class NewLanguageChange extends LanguageEvent {
  String language;
  NewLanguageChange(this.language);
}
