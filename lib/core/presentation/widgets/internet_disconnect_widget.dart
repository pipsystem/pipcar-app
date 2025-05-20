import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../common/configs/constants/app_dimens.dart';
import '../../../common/themes/theme_color.dart';
import 'text_widget/style_lable.dart';

class InternetDisconnect extends StatelessWidget {
  const InternetDisconnect({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(
          AppDimens.borderSmall,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.wifi_off,
            color: AppColor.red,
          ).paddingSymmetric(horizontal: 10.w),
          StyleLabel(
            title: translate("internet_disconnected"),
          )
        ],
      ),
    ).paddingAll(AppDimens.paddingVerySmall);
  }
}
