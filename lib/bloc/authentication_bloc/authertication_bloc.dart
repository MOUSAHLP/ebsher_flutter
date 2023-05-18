import 'dart:async';

import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(
    this.userRepository,
  ) : super(AuthenticationUninitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AppStarted) {
        final bool hasToken = await userRepository.hasToken();
        await Future.delayed(Duration(seconds: 4)).then((value) {
          if (hasToken) {
            emit(AuthenticationAuthenticated());
          } else {
            emit(AuthenticationUnauthenticated());
          }
        });
      }

      if (event is LoggedIn) {
        DataStore.instance.setToken(event.token);
        emit(AuthenticationAuthenticated());
      }

      if (event is LoggedOut) {
        userRepository.deleteToken();
        emit(AuthenticationLoggedOut());
      }
    });
  }
}
