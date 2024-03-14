import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> launchSocial(String url) async {
  try {
    print("launchSocial");
    print(url);
    await launchUrl(Uri.parse(url));
  } catch (e) {
    if (kDebugMode) {
      print('Error launching URL: $e');
    }
  }
}

// void launchWhatsApp(String url) async {
//   print(url);
//   String phoneNumber = "963954847026";
//   String whatsappUrl = 'https://wa.me/$phoneNumber';
//
//   if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
//     await launchUrl(Uri.parse(whatsappUrl));
//   } else {
//     if (kDebugMode) {
//       print('Could not launch WhatsApp.');
//     }
//   }
// }

openWhatsApp(String whatsapp, context) async {
  var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
  var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatappURLIos))) {
      await launchUrl(Uri.parse(whatappURLIos));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Can not open Whatsapp")));
    }
  } else {
    // android , web
    print("ghina");
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Can not open Whatsapp")));
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


void launchUrlFaceBook(String urlFaceBook) async{
  var url = 'fb://facewebmodal/f?href=$urlFaceBook';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse( url), );
  } else { throw 'There was a problem to open the url: $url'; }
}
