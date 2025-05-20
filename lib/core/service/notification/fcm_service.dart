import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseMessagingService {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    ledColor: Colors.white,
  );

  Future<void> initService() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.getToken().then((value) {
      log('Generated fcm token: $value');
      if (value != null) {
        LocalStorage.deviceId.val = value;
      }
    }, onError: (err) {
      log('Get Token Firebase Messaging failed: $err');
      // showAlertDialog("Thông báo", "Không thể kết nối đến server. Vui lòng thử lại sau", "OK", () {});
    });
  }
}
