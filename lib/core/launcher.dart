import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchSocial(String url) async {

    await launch(url, forceSafariVC: false, forceWebView: false);
}