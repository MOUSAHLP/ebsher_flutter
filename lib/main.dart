import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:absher/data/data_resource/local_resource/data_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/firebase_notifications_handler.dart';
import 'core/services/services_locator.dart';
import 'data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'my_app.dart';

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
  await Firebase.initializeApp();
  await FirebaseNotificationsHandler().init();
  ServicesLocator().init();
  BaseApiClient();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await DataStore.instance.init();
  runApp(const MyApp());
}
