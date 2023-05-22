import 'dart:io';

import 'package:absher/bloc/authentication_bloc/authentication_event.dart';
import 'package:absher/bloc/authentication_bloc/authentication_state.dart';
import 'package:absher/bloc/login_bloc/login_event.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/presentation/screens/auth_screen/account_screen.dart';
import 'package:absher/presentation/screens/auth_screen/sign_up_screen.dart';
import 'package:absher/presentation/screens/home_screen/basic_screen.dart';
import 'package:absher/presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:absher/presentation/screens/splash_screen/splash_screen.dart';
import 'package:absher/presentation/widgets/dialogs/will_pop_scope_handler.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import 'bloc/authentication_bloc/authertication_bloc.dart';
import 'bloc/category_bloc/category_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/sign_up_bloc/sign_up_bloc.dart';
import 'core/services/services_locator.dart';
import 'data/data_resource/remote_resource/api_handler/base_api_client.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  BaseApiClient();
  await DataStore.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
          create: (BuildContext context) => sl<CategoryBloc>(),
        ),
      ],
      child: OverlaySupport.global(
        child: GestureDetector(
          onTap: () {
            print('Tapped');
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild?.unfocus();
              currentFocus.unfocus();
            }
          },
          child: MaterialApp(
            title: 'أبشر',
            locale: Locale('en'),
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
                  return const BasicScreen();
                }
                if (state is AuthenticationUnauthenticated) {
                  return const OnBoardingScreen();
                }
                if (state is AuthenticationLoggedOut)
                  return const AccountScreen();
                return const SplashScreen();
              },
            ),
            // home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
