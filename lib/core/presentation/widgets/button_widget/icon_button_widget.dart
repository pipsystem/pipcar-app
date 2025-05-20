// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/themes/theme_color.dart';
import 'button_constants.dart';

class IconButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String iconSource;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? size;
  final double? iconHeight;

  const IconButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.iconSource,
      this.iconColor,
      this.buttonColor,
      this.borderColor,
      this.size,
      this.iconHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        width: size ?? ButtonConstants.iconButtonSize,
        height: size ?? ButtonConstants.iconButtonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor ?? buttonColor ?? AppColor.buttonColor),
          color: buttonColor ?? AppColor.buttonColor,
        ),
        child: SvgPicture.asset(
          iconSource,
          height: iconHeight ?? ButtonConstants.iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
