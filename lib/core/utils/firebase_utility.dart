import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // Handle the notification here
    flutterLocalNotificationsPlugin.show(
        0,
        "${message.notification?.title}",
        "${message.notification?.body}",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, // id
                channel.name, // title
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher'),
            iOS: const DarwinNotificationDetails(
                presentSound: true, presentAlert: true, presentBadge: true)),
        payload: 'Open from Local Notification');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    printLog(msg: 'Notification clicked! The app was in background.');
    getSnackbar(
        title: "onMessageOpenedApp",
        subTitle: "${message.notification?.body}",
        isSuccess: true);
    // if (message.data.containsKey('screen')) {
    //   String screenName = message.data['screen'];
    //
    //   // Navigate to the specific screen
    //   if (screenName == 'chat') {
    //     Navigator.pushNamed(context, '/chat');
    //   } else if (screenName == 'profile') {
    //     Navigator.pushNamed(context, '/profile');
    //   }
    // }
  });
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  getFcmToken();
}

getFcmToken() async {
  String? token = "";
  try {
    token = await FirebaseMessaging.instance.getToken();
    printLog(msg: "Firebase Token : $token");
  } catch (error) {
    printLog(msg: "Firebase Token Error $error");
  }
  return token;
}

logFcmEvent(String eventName, Map<String, Object>? param) {
  FirebaseAnalytics.instance.logEvent(
    name: 'event_name',
    parameters: param,
  );
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      // case TargetPlatform.iOS:
      //   return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // static const FirebaseOptions web = FirebaseOptions(
  //   apiKey: 'AIzaSyA-MkM1z8YGc_yJ4Z1r3LGsdfOtmknak',
  //   appId: '1:67977657210:web:e3da4fad4b11aa4473b4c3',
  //   messagingSenderId: '67977657210',
  //   projectId: 'movies4u0',
  //   authDomain: 'movies4u0.firebaseapp.com',
  //   databaseURL: 'https://movies4u0-default-rtdb.firebaseio.com',
  //   storageBucket: 'movies4u0.appspot.com',
  //   measurementId: 'G-C2QWDT793Q',
  // );

  static const FirebaseOptions web = FirebaseOptions(
  apiKey: "AIzaSyBe2BuCGdIDWMWBd7eLeq_mqfU6FmVL5MA",
  authDomain: "pingmexx.firebaseapp.com",
  databaseURL: "https://pingmexx-default-rtdb.firebaseio.com",
  projectId: "pingmexx",
  storageBucket: "pingmexx.firebasestorage.app",
  messagingSenderId: "798685713139",
  appId: "1:798685713139:web:a5fd7483073d3c1dca1d86",
  measurementId: "G-R1BY6CD4S0"
  );


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBe2BuCGdIDWMWBd7eLeq_mqfU6FmVL5MA",
    appId: "1:798685713139:web:a5fd7483073d3c1dca1d86",
    messagingSenderId: "798685713139",
    databaseURL: "https://pingmexx-default-rtdb.firebaseio.com",
    projectId: "pingmexx",
    storageBucket: "pingmexx.firebasestorage.app",
  );

  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyAa4RRBD1t2Kiiwqaedefgg6a7DIt_hM',
  //   appId: '1:67977657210:ios:c04bd17a952a9f9273b4c3',
  //   messagingSenderId: '67977657210',
  //   projectId: 'movies4u0',
  //   databaseURL: 'https://movies4u0-default-rtdb.firebaseio.com',
  //   storageBucket: 'movies4u0.appspot.com',
  //   iosBundleId: 'com.ezeego.ezeegopartner',
  // );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  printLog(msg: 'A bg message just showed up :  ${message.messageId}');
  if (message.notification != null) {
    getSnackbar(
        title:
            "_firebaseMessagingBackgroundHandler ${message.notification?.title}",
        subTitle: "${message.notification?.body}",
        isSuccess: true);
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true);

final logger = Logger();
printLog(
    {String tag = "",
      required dynamic msg,
      bool status = true}) {
  // if (ApiConstant.isDebug) {
  print("$tag : $msg");
  if (status ) {
    logger.d("$tag : $msg");
  } else {
    logger.e("$tag : $msg");
  }
  // }
}
getSnackbar(
    {String? title, String? subTitle = "", bool isSuccess = true}) {
  printLog(msg: 'object: data $title\n$subTitle');
  try {
    Get.snackbar(title ?? "appName", subTitle ?? "",
        backgroundColor:
        isSuccess ? Colors.green : Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3));
  } catch (exc) {
    printLog(msg: "exc $exc");
  }
}

