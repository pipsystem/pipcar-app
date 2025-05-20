import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'themes.dart';

class FontFamily {
  // static const String roboto = 'Roboto';
  static const String quicksand = 'Quicksand';
}

class FontType {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;
}

class ThemeText {
  ///22
  static TextStyle appBar = TextStyle(
    fontSize: 18.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w700,
    fontFamily: FontFamily.quicksand,
  );

  ///22
  static TextStyle subtitle1 = TextStyle(
    fontSize: 24.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.quicksand
  );

  ///18
  static TextStyle subtitle2 = TextStyle(
    fontSize: 20.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.quicksand
  );

  ///18
  static TextStyle body1 = TextStyle(
    fontSize: 20.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w500,
    fontFamily: FontFamily.quicksand
  );

  ///1
  static TextStyle body2 = TextStyle(
    fontSize: 18.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w700,
    fontFamily: FontFamily.quicksand
  );

  ///16
  static TextStyle button = TextStyle(
    fontSize: 18.sp,
    color: AppColor.white,
    fontWeight: FontWeight.w700,
    fontFamily: FontFamily.quicksand
  );

  ///14
  static TextStyle caption = TextStyle(
    fontSize: 16.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.none,
    decorationColor: AppColor.textColor,
    fontFamily: FontFamily.quicksand
  );

  ///15
  static TextStyle mediumTextTicket = TextStyle(
    fontSize: 15.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.normal,
    fontFamily: FontFamily.quicksand
  );

  ///12
  static TextStyle smallTextTicket = TextStyle(
    fontSize: 14.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w300,
    fontFamily: FontFamily.quicksand
  );

  ///12
  static TextStyle style12Regular = TextStyle(
    fontSize: 14.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.normal,
    fontFamily: FontFamily.quicksand
  );

  ///11
  static TextStyle note = TextStyle(
    fontSize: 13.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w300,
    fontFamily: FontFamily.quicksand
  );

  ///10
  static TextStyle noteSmall = TextStyle(
    fontSize: 13.sp,
    color: AppColor.textColor,
    fontWeight: FontWeight.w300,
    fontFamily: FontFamily.quicksand
  );
}
