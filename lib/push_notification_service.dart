//
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//
//import 'package:overlay_support/overlay_support.dart';
//class MyNotification {
//  static Future<void> initialize() async {
//    FirebaseMessaging.instance
//        .getToken()
//     ;
//    FirebaseMessaging.onMessage.listen((RemoteMessage message)
//    {
//      showOverlayNotification(
//              (overlayContext) {
//            return SafeArea(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: ClipRRect(
//                  borderRadius: BorderRadius.circular(10),
//                  child: Material(
//                    child: Container(
//                      child: ListTile(
//                        tileColor: Colors.white,
//                        leading: const Icon(
//                          Icons.notifications,
//                          color: Colors.black,
//                          // isDark
//                          //     ? Theme.of(overlayContext).primaryColor
//                          //     : Theme.of(overlayContext).primaryColor,
//                        ),
//                        onTap: () {
//                       //   overlay.dismiss(animate: false);
//                         // Navigator.of(context).push(MaterialPageRoute(builder:(context) =>  LoginScreen()));
//                        },
//                        title: Text(message!.notification?.title??"",
//                            style:Theme.of(overlayContext).textTheme.subtitle2),
//                        subtitle: Text( message.notification?.body??"",
//                            style:Theme.of(overlayContext).textTheme.subtitle1),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            );});
//    });
//
//
//  }
//}
//Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//  print("onBackground: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
//}
//
