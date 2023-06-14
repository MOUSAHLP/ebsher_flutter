
abstract class LanguageState {}
class LanguageInit extends LanguageState {}

class NewLanguage extends LanguageState {
  String language="en";
  NewLanguage(this.language);
}
