import 'package:absher/models/params/sign_up_params.dart';

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

class SignUp extends SignUpEvent {
  final SignUpParams signUpParams;
  SignUp({required this.signUpParams}) : super([signUpParams]);
}
