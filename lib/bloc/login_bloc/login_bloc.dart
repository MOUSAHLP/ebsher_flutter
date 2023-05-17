import 'package:bloc/bloc.dart';

import '../../data/repos/user_repository.dart';
import '../authentication_bloc/authentication_event.dart';
import '../authentication_bloc/authertication_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc(this.userRepository, this.authenticationBloc)
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        final token = await userRepository.authenticate(
          phoneNumber: event.phoneNumber,
          password: event.password,
        );
        authenticationBloc.add(LoggedIn(token: token));
        emit(LoginInitial());
        // emit(LoginFailure(error: error.toString()));
      }
    });
  }
}
