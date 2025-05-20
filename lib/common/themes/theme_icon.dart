import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'theme_color.dart';

class ThemeIcon {
  static IconThemeData getDefaultIconTheme() => const IconThemeData();
}

extension CustomIconTheme on IconThemeData {
  IconThemeData get appBarIconTheme => IconThemeData(
        color: AppColor.primaryColor,
        size: 18.sp,
      );
}
