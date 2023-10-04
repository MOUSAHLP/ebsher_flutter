import 'package:absher/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:absher/bloc/vendor_details_bloc/vendor_details_bloc.dart';
import 'package:absher/data/repos/user_repository.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/about_bloc/about_bloc.dart';
import '../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../bloc/bottom_bloc/bottom_bloc.dart';
import '../../bloc/favorites_list_bloc/favorites_list_bloc.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../bloc/language_bloc/language_bloc.dart';
import '../../bloc/location_bloc/location_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../bloc/notification_bloc/notification_bloc.dart';
import '../../bloc/privacy_bloc/privacy_bloc.dart';
import '../../bloc/profile_bloc/pofile_bloc.dart';
import '../../bloc/reels_bloc/reels_bloc.dart';
import '../../bloc/search_bloc/search_bloc.dart';
import '../../bloc/sub_category_bloc/sub_category_bloc.dart';
import '../../bloc/vendors_list_bloc/vendors_list_bloc.dart';
import '../../models/params/get_vendors_params.dart';


final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    sl.registerLazySingleton(() => AuthenticationBloc(sl()));
    sl.registerLazySingleton(() => SignUpBloc(sl()));
    sl.registerLazySingleton(() => LoginBloc(sl(), sl()));
    sl.registerLazySingleton(() => HomeBloc());
    sl.registerFactory(() => SubCategoryBloc());
    sl.registerFactory(() => ProfileBloc());
    sl.registerFactory(() => ReelsBloc());
    sl.registerFactory(() => SearchBloc());
    sl.registerLazySingleton(() => FavoritesListBloc());
    sl.registerLazySingleton(() => NotificationBloc());
    sl.registerFactory(() => AboutBloc());
    sl.registerFactory(() => PrivacyBloc());
    sl.registerFactory(() => LocationBloc());
    sl.registerFactory(() => VendorDetailsBloc());
    // sl.registerFactory(() => VendorsListBloc(appliedFilter: GetVendorsParams()));
    sl.registerLazySingleton(() => BottomBloc());
    sl.registerLazySingleton(() => LanguageBloc());

    /// Repository
    sl.registerLazySingleton<UserRepository>(() => UserRepository());
  }
}
