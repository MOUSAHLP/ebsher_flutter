import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchSocial(String url) async {
  try {
    await launchUrl(Uri.parse(url));
  } catch (e) {
    if (kDebugMode) {
      print('Error launching URL: $e');
    }
  }
}

void launchWhatsApp(String url) async {
  String phoneNumber = url;
  String whatsappUrl = 'https://wa.me/$phoneNumber';

  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {
    if (kDebugMode) {
      print('Could not launch WhatsApp.');
    }
  }
}

void launchEmail({required String email}) async {
  // String encodedSubject = Uri.encodeComponent(subject);
  // String encodedBody = Uri.encodeComponent(body);
  //?subject=$encodedSubject&body=$encodedBody&headers=header1:$name
  String mailtoLink = 'mailto:$email';

  if (await canLaunchUrl(Uri.parse(mailtoLink))) {
    await launchUrl(Uri.parse(mailtoLink));
  } else {
    throw 'Could not launch $mailtoLink';
  }
}

void launchPhoneCall(String phoneNumber) async {
  final Uri phoneCallUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneCallUri)) {
    await launchUrl(phoneCallUri);
  } else {
    throw 'Could not launch $phoneCallUri';
  }
}

void launchBrowser(String link) async {
  if (await canLaunchUrl(Uri.parse(link))) {
    await launchUrl(Uri.parse(link));
  } else {
    throw 'Could not launch $link';
  }
}
