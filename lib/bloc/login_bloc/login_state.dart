abstract class LoginState {}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  String error;
  LoginError(this.error);
}

class LoginConfirmed extends LoginState {}

class ForgetPassword extends LoginState {}
class LoginFieldsValidationFailed extends LoginState {
  final String? validationError;

  LoginFieldsValidationFailed({this.validationError});
}
class TermsAcceptRequired extends LoginState {}
