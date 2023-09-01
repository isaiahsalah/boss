//SHA1: 06:89:8D:71:9D:1A:52:3E:D5:5E:39:F9:F2:1A:60:C2:33:2F:61:A5
//fDVNh2ceTS2MWRp47SCVvr:APA91bHA2dzviisawoR9mCi6H_qiIgh3076lpYzqPHyGcVfeJtXk7YYrbjSG1WhKMyg1IuAPXWsVSbn3wB7uHAgxbe9rUB_Rf5XKETsgs5qN5y08Oud23rKaVJMx1AJs2DoWFQ-7i4qS

import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  //print('background Handler: ${message.messageId}');
}

Future<void> _onMessageHandler(RemoteMessage message) async {
  //print('on message Handler: ${message.messageId}');
}

Future<void> _onMessageOpenApp(RemoteMessage message) async {
  //print('on message open app Handler: ${message.messageId}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _messageStreamController = StreamController<String>.broadcast();
  Stream<String> get message => _messageStreamController.stream;

  Future<void> initNotifications(BuildContext context) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    //print('User granted permission: ${settings.authorizationStatus}');

    //await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    //print('Token: $fcmToken');
    String arg = "no-data";
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        arg = message.messageId.toString() ?? "no-data";
      }
      _messageStreamController.sink.add(arg);

      //print('on message Handleraaa: ${message.messageId}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        arg = message.messageId.toString() ?? "no-data";
      }
      _messageStreamController.sink.add(arg);
      //print('on message open app Handler: ${message.messageId}');
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      if (Platform.isAndroid) {
        arg = message.messageId.toString() ?? "no-data";
      }
      _messageStreamController.sink.add(arg);
      //print('background Handler: ${message.messageId}');
    });
  }

  Dispose() {
    _messageStreamController.close();
  }
}
