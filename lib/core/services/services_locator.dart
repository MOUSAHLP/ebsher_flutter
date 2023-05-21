import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../bloc/category_bloc/category_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    sl.registerLazySingleton(() => AuthenticationBloc(sl()));
    sl.registerLazySingleton(() => SignUpBloc(sl()));
    sl.registerLazySingleton(() => LoginBloc(sl(),sl()));
    sl.registerLazySingleton(() => HomeBloc());

    /// Repository
    sl.registerLazySingleton<UserRepository>(() => UserRepository());
  }
}
