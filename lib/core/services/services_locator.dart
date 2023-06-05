import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../bloc/favorites_list_bloc/favorites_list_bloc.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/location_bloc/location_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/search_bloc/search_bloc.dart';
import '../../bloc/vendors_list_bloc/vendors_list_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    sl.registerLazySingleton(() => AuthenticationBloc(sl()));
    sl.registerLazySingleton(() => SignUpBloc(sl()));
    sl.registerLazySingleton(() => LoginBloc(sl(), sl()));
    sl.registerLazySingleton(() => HomeBloc());
    sl.registerLazySingleton(() => SearchBloc());
    sl.registerFactory(() => VendorsListBloc());
    sl.registerFactory(() => FavoritesListBloc());
    sl.registerFactory(() => LocationBloc());
    sl.registerLazySingleton(() => BottomBloc());

    /// Repository
    sl.registerLazySingleton<UserRepository>(() => UserRepository());
  }
}
