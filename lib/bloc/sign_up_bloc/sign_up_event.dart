
abstract class SignUpEvent {
  SignUpEvent([List props = const []]) : super();
}

class RequestOtp extends SignUpEvent {
  final String phoneNumber;
  RequestOtp({required this.phoneNumber}) : super([phoneNumber]);
}

class ConfirmOtp extends SignUpEvent {
  final String code;
  ConfirmOtp({required this.code}) : super([code]);
}

class SignUp extends SignUpEvent {}

class ForgetPasswordGenerateOtp extends SignUpEvent {
  final String phoneNumber;
  ForgetPasswordGenerateOtp({required this.phoneNumber}) : super([phoneNumber]);
}

class ForgetPassword extends SignUpEvent {
  final String password;
  final String repeatPassword;
  ForgetPassword({required this.password, required this.repeatPassword})
      : super([password, repeatPassword]);
}
class ResetPassword extends SignUpEvent {
  final String password;
  final String oldPassword;
  final String repeatPassword;
  ResetPassword({required this.password, required this.repeatPassword,required this.oldPassword})
      : super([password, repeatPassword,oldPassword]);
}