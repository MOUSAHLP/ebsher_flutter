

abstract class AboutState {}

class AboutLoading extends AboutState {}

class AboutError extends AboutState {
  String error;
  AboutError(this.error);
}
class AboutSuccess extends AboutState {
  String content;

  AboutSuccess(this.content,);
}
