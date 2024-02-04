import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
Future<void> launchSocial(String url) async {
  try {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } catch (e) {
    if (kDebugMode) {
      print('Error launching URL: $e');
    }
  }
}
void launchWhatsApp(String url) async {

  String phoneNumber = url;
  String whatsappUrl = 'https://wa.me/$phoneNumber';

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    if (kDebugMode) {
      print('Could not launch WhatsApp.');
    }
  }
}
