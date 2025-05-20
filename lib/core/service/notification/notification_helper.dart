import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import '../../../common/configs/constants/app_dimens.dart';
import '../../../common/themes/themes.dart';
import '../../presentation/widgets/widgets.dart';
import 'fcm_service.dart';

class NotificationHelper {
  static RemoteMessage? fcmMessage;
  static bool fCmByBackGround = true;

  static void configFCM() {
    initLocalNoti();
    foregroundReceiveFCM();
  }

  static void initLocalNoti() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('icon_app');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});
    const DarwinInitializationSettings initializationSettingsMacOS =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectLocalNotification,
        onDidReceiveNotificationResponse: onSelectLocalNotification);
  }

  static Future<void> showLocalNotification(RemoteMessage fcmMessage) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
              'high_importance_channel', 'High Importance Notifications',
              importance: Importance.max,
              priority: Priority.high,
              enableLights: true,
              largeIcon: DrawableResourceAndroidBitmap('icon_app'),
              ticker: 'ticker');
      const DarwinNotificationDetails iosPlatformChannelSpecifics =
          DarwinNotificationDetails();
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iosPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond + DateTime.now().second,
        fcmMessage.notification?.title,
        fcmMessage.notification?.body,
        platformChannelSpecifics,
        payload: jsonEncode(fcmMessage.data),
      );
    } catch (e) {
      log("Không show được thông báo roy .-.$e");
    }
  }

  static void foregroundReceiveFCM() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      onSelectFirebaseNoti(message, fromTermiated: true);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      handelFcmMessageForeground(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log('handleClickFCM_onMessageOpenedApp: ${message.data}');
      onSelectFirebaseNoti(message);
    });
  }

  static void handelFcmMessageForeground(RemoteMessage message) async {
    // showLocalNotification(message);
    // showsnnack bar when openApp
    await Flushbar(
      onTap: (Flushbar flushbar) {
        onSelectFirebaseNoti(message);
      },
      titleText: Row(children: [
        Container(
          padding: EdgeInsets.only(right: 5.w),
          child: ImageAppWidget(
            width: 20.w,
            height: 20.w,
            path: Assets.images.icPipcar.keyName,
          ),
        ),
        Expanded(
          child: StyleLabel(
            title: message.notification?.title ?? "",
            style: ThemeText.style12Regular.copyWith(fontWeight: FontType.bold),
          ),
        ),
      ]),
      messageText: StyleLabel(
        title: message.notification?.body ?? "",
        style: ThemeText.style12Regular
            .copyWith(fontWeight: FontType.regular, color: AppColor.black),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(AppDimens.borderSmall),
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      duration: const Duration(seconds: 10),
      boxShadows: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
      backgroundColor: const Color.fromARGB(255, 250, 253, 255),
    ).show(getIt.get<AppRouter>().navigatorKey.currentState!.context);
  }

  static void onSelectFirebaseNoti(RemoteMessage? message,
      {bool fromTermiated = false}) {
    handleServiceOnClick(message?.data, fromTermiated: fromTermiated);
  }

  static onSelectLocalNotification(
      NotificationResponse notificationResponse) async {
    var payloadData = jsonDecode(notificationResponse.payload ?? "");
    handleServiceOnClick(payloadData);
  }

  static handleServiceOnClick(Map<String, dynamic>? payload,
      {bool fromTermiated = false}) async {
    if (fromTermiated) {
      LocalStorage.payloadNotify.val = jsonEncode(payload);
    } else {
      final router =
          getIt.get<AppRouter>().navigatorKey.currentState!.context.router;
      switch (payload?['action_type'].toString()) {
        case "1":
          if (payload?['id'] != null) {
            router.push(NewDetailsPageRoute(ticketId: payload?['id']));
          }
          break;
        case "2":
          router.pushNamed(Routes.sytemSchedule);
          break;
        case "3":
          if (payload?['id'] != null) {
            router.push(MyAcceptedDetailsPageRoute(ticketId: payload?['id']));
          }
          break;
        case "4":
          if (payload?['id'] != null) {
            router.push(MyAcceptedDetailsPageRoute(ticketId: payload?['id']));
          }
          break;
        case "5":
          if (payload?['id'] != null) {
            router.push(MyCompleteDetailsPageRoute(ticketId: payload?['id']));
          }
          break;
        case "6":
          if (payload?['id'] != null) {
            router.push(DetailsPassPageRoute(ticketId: payload?['id']));
          }
          break;
        case "7":
          if (payload?['id'] != null) {
            router.push(DetailsAcceptedPageRoute(ticketId: payload?['id']));
          }
          break;
        default:
      }
    }
  }
}
