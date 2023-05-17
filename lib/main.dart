import 'package:absher/bloc/authentication_bloc/authentication_event.dart';
import 'package:absher/bloc/authentication_bloc/authentication_state.dart';
import 'package:absher/presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:absher/presentation/screens/splash_screen/splash_screen.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/authentication_bloc/authertication_bloc.dart';
import 'core/services/services_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: Locale('ar'),
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
            if (state is AuthenticationUninitialized) return SplashScreen();
            if (state is AuthenticationAuthenticated)
              // TODO: Return HomeScreen
              return Container();
            if (state is AuthenticationUnauthenticated)
              return OnBoardingScreen();
            // TODO: Return Loading Screen
            return Container();
          },
        ),
        // home: const SplashScreen(),
      ),
    );
  }
}
