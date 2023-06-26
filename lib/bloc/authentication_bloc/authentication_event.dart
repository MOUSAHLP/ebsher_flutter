import 'package:absher/models/login_response.dart';

abstract class AuthenticationEvent {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final LoginResponse loginResponse;

  LoggedIn({required this.loginResponse}) : super([loginResponse]);

  @override
  String toString() => 'LoggedIn { token: $loginResponse }';
}

class LoggedOut extends AuthenticationEvent {}
class LoggedGuest extends AuthenticationEvent {}
