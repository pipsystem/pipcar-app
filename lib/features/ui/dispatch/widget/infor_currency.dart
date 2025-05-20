// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class InforCurrency extends StatelessWidget {
  final String title;
  final String amount;
  final String iconPath;
  const InforCurrency({
    Key? key,
    required this.title,
    required this.amount,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageAppWidget(
          path: iconPath,
          width: 18.w,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StyleLabel(
              title: title,
              style: ThemeText.note.copyWith(height: 0),
            ),
            StyleLabel(
              title: amount,
              style: ThemeText.body2.copyWith(height: 1.5),
            ),
          ],
        )
      ],
    ).paddingSymmetric(vertical: 10.h);
  }
}
