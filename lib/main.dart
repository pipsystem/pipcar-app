import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';

import 'common/configs/constants/language_constants.dart';
import 'common/initializer/init.dart';
import 'core/presentation/app/app.dart';
import 'core/presentation/bloc/bloc_observer.dart';
import 'core/service/text_to_speech/flutter_tts.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  // NotificationHelper.onSelectFirebaseNoti(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.init();
  HttpOverrides.global = MyHttpOverrides();
  initializeDateFormatting();
  await GetStorage.init();
  Bloc.observer = MyBlocObserver();
  FlutterTtsService.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final delegate = await LocalizationDelegate.create(
    fallbackLocale: LanguageConstants.en,
    supportedLocales: [
      LanguageConstants.vi,
      LanguageConstants.en,
    ],
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarIconBrightness: Brightness.dark,
  //     statusBarColor: Colors.black,
  // ));
  runApp(
    LocalizedApp(
      delegate,
      const App(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
