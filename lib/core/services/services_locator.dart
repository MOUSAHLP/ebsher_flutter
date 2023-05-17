import 'package:absher/data/repos/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/authentication_bloc/authertication_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    sl.registerFactory(() => AuthenticationBloc(sl()));

    /// Repository
    sl.registerLazySingleton<UserRepository>(() => UserRepository());
  }
}
