import 'package:absher/bloc/authentication_bloc/authentication_event.dart';
import 'package:absher/bloc/authentication_bloc/authentication_state.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/presentation/screens/auth_screen/account_screen.dart';
import 'package:absher/presentation/screens/home_screen/basic_screen.dart';
import 'package:absher/presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:absher/presentation/screens/splash_screen/splash_screen.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'bloc/authentication_bloc/authertication_bloc.dart';
import 'bloc/bottom_bloc/bottom_bloc.dart';
import 'bloc/favorites_list_bloc/favorites_list_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/language_bloc/language_bloc.dart';
import 'bloc/language_bloc/language_state.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/notification_bloc/notification_bloc.dart';

import 'bloc/sign_up_bloc/sign_up_bloc.dart';
import 'core/services/services_locator.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      designSize: const Size(100, 100),
      builder: (context, ctx) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (BuildContext context) => sl<AuthenticationBloc>()),
              BlocProvider(
                create: (BuildContext context) => sl<SignUpBloc>(),
                lazy: false,
              ),
              BlocProvider(
                create: (BuildContext context) => sl<LoginBloc>(),
                lazy: false,
              ),
              BlocProvider(
                create: (BuildContext context) => sl<HomeBloc>(),
              ),
              // BlocProvider(
              //   create: (BuildContext context) => sl<SearchBloc>(),
              // ),
              BlocProvider(
                create: (BuildContext context) => sl<BottomBloc>(),
              ),
              BlocProvider(
                create: (BuildContext context) => sl<LanguageBloc>(),
              ),
              BlocProvider(
                create: (BuildContext context) => sl<FavoritesListBloc>(),
              ),
              BlocProvider(
                create: (BuildContext context) => sl<NotificationBloc>(),
              ),
            ],
            child: OverlaySupport.global(
                child: GestureDetector(onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild?.unfocus();
                currentFocus.unfocus();
              }
            }, child: BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, state) {
              if (true) {
                return MaterialApp(
                  title: 'أبشر',
                  locale: Locale(DataStore.instance.lang),
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    bloc: sl<AuthenticationBloc>()..add(AppStarted()),
                    builder: (context, state) {
                      if (state is AuthenticationAuthenticated) {
                        return BasicScreen();
                      }
                      if (state is AuthenticationUnauthenticated) {
                        return const OnBoardingScreen();
                      }
                      if (state is AuthenticationLoggedOut) {
                        return const AccountScreen();
                      }
                      return const SplashScreen();
                    },
                  ),
                  // home: const SplashScreen(),
                );
              }
            }))));
      },
    );
  }
}
