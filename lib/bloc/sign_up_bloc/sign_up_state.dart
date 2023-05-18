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
