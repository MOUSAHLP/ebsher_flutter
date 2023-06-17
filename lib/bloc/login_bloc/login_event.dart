import '../../models/params/login_params.dart';

abstract class LoginEvent {
  const LoginEvent([List props = const []]) : super();
}

class Login extends LoginEvent {
  final LoginParams loginParams;
  Login({required this.loginParams}) : super([loginParams]);
}

class CheckForTermsAcceptance extends LoginEvent {}
