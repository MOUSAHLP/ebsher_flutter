import 'package:absher/bloc/authentication_bloc/authentication_event.dart';
import 'package:absher/bloc/authentication_bloc/authentication_state.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:absher/presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:absher/presentation/screens/splash_screen/splash_screen.dart';
import 'package:absher/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import 'bloc/authentication_bloc/authertication_bloc.dart';
import 'bloc/sign_up_bloc/sign_up_bloc.dart';
import 'core/services/services_locator.dart';
import 'data/data_resource/remote_resource/api_handler/base_api_client.dart';

void main() async {
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
      ],
      child: OverlaySupport.global(
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
      ),
    );
  }
}
