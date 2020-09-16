import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tes_simetris/base/home.dart';
import 'package:tes_simetris/database/db/pesan_api_provider.dart';
import 'package:tes_simetris/ui/pesan_page.dart';

class Firebasess {
  final context;

  Firebasess({this.context});

  final _key = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  var apiProvider = PesanApiProvider();

  initNotifications() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(
            message['notification']['title'], message['notification']['body']);
        apiProvider.getAllRemoteData();
        print(message['data']);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        apiProvider.getAllRemoteData();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainMenu(selectTab: 1)));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        apiProvider.getAllRemoteData();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MainMenu(selectTab: 1)));
      },
    );
  }

  void showNotification(String title, String body) async {
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.Max,
        playSound: true,
        // sound: 'sound',
        showProgress: true,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  Future onSelectNotification(String payload) async {
    apiProvider.getAllRemoteData();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => MainMenu(selectTab: 1)));
  }
}
