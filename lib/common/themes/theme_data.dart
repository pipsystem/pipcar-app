import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../configs/constants/app_dimens.dart';
import 'themes.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: FontFamily.quicksand,
    primaryColor: AppColor.primaryColor,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.roundedRadius),
      ),
    ),
    scaffoldBackgroundColor: AppColor.backgroundColor,
    iconTheme: ThemeIcon.getDefaultIconTheme(),
    appBarTheme: const AppBarTheme(
        color: AppColor.backgroundColor,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: AppColor.ebonyClay),
      unselectedIconTheme: IconThemeData(color: AppColor.grey),
      unselectedLabelStyle: TextStyle(color: AppColor.grey),
      selectedLabelStyle: TextStyle(color: AppColor.ebonyClay),
      unselectedItemColor: AppColor.grey,
      selectedItemColor: AppColor.ebonyClay,
    ),
    cardColor: AppColor.paleGrey,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.ebonyClay,
      foregroundColor: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.primaryColor,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
        }),
  );
}
