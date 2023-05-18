import 'package:equatable/equatable.dart';

import '../../models/params/login_params.dart';
import '../../models/params/sign_up_params.dart';

abstract class LoginEvent {
  const LoginEvent([List props = const []]) : super();
}


class Login extends LoginEvent {
  final LoginParams loginParams;
  Login({required this.loginParams}) : super([loginParams]);
}

