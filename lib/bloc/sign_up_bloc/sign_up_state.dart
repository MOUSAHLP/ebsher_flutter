abstract class SignUpState {}

class SignUpInit extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {
  final String? error;

  SignUpError({this.error});
}

class SignUpOtpRequested extends SignUpState {}

class SignUpOtpConfirmed extends SignUpState {}

class SignUpCompleted extends SignUpState {}

class SignUpFieldsValidationFailed extends SignUpState {
  final String? validationError;

  SignUpFieldsValidationFailed({this.validationError});
}

class PhoneFieldsValidationFailed extends SignUpState {
  final String? validationError;
  PhoneFieldsValidationFailed({this.validationError});
}
class PasswordFieldsValidationFailed extends SignUpState {
  final String? validationError;
  PasswordFieldsValidationFailed({this.validationError});
}
class ForgetPasswordCompleted extends SignUpState {}
class ResetPasswordCompleted extends SignUpState {}
