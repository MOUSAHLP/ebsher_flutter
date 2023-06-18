abstract class PrivacyState {}

class PrivacyLoading extends PrivacyState {}

class PrivacyError extends PrivacyState {
  String error;
  PrivacyError(this.error);
}

class PrivacySuccess extends PrivacyState {
  String content;

  PrivacySuccess(
    this.content,
  );
}
