import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/switch_widget/switch_widget.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class CardFormView extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? colorBoder;
  const CardFormView({super.key, required this.child, this.padding, this.colorBoder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppDimens.paddingVerySmall),
      constraints:
          BoxConstraints(minHeight: MediaQuery.sizeOf(context).height / 11),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppDimens.borderSmall),
          border: Border.all(color: colorBoder ?? AppColor.borderCard, width: 0.5)),
      child: child,
    );
  }
}

class ButtonStyle1 extends StatelessWidget {
  final Widget? prefixIcon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  const ButtonStyle1({
    Key? key,
    this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFormView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          prefixIcon ?? const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StyleLabel(
                title: title,
                style: ThemeText.body2,
              ),
              StyleLabel(
                title: subtitle,
                style: ThemeText.note.copyWith(height: 1.4, color: AppColor.primaryColor),
              ),
            ],
          ).paddingSymmetric(horizontal: AppDimens.paddingSmall).expand(),
          ImageAppWidget(
            height: 24.h,
            path: Assets.images.icArrowRight2.keyName,
            color: AppColor.primaryColor,
          ).paddingRight(AppDimens.paddingSmall)
        ],
      ),
    ).onTap(() => onPressed()).paddingBottom(AppDimens.paddingSmall);
  }
}

class ButtonStyle2 extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Color? borderFormColor;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final bool hasAction;
  final bool checkBox;
  final bool check;
  const ButtonStyle2({
    Key? key,
    this.prefixIcon,
    this.sufixIcon,
    this.borderFormColor,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.hasAction = true,
    this.checkBox = false,
    this.check = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFormView(
      colorBoder: borderFormColor,
      child: FormChildButtonStyle2(
        prefixIcon: prefixIcon,
        sufixIcon: sufixIcon,
        title: title,
        subtitle: subtitle,
        hasAction: hasAction,
        checkBox: checkBox,
        check: check,
      ),
    ).onTap(onPressed).paddingBottom(AppDimens.paddingSmall);
  }
}

class FormChildButtonStyle2 extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Widget? subIcon;
  final String title;
  final String subtitle;
  final bool hasAction;
  final bool? check;
  final bool checkBox;
  final VoidCallback? onTapCheckBox;
  final VoidCallback? onTapSubIcon;
  final VoidCallback? onTapSufixIcon;
  const FormChildButtonStyle2({
    Key? key,
    this.prefixIcon,
    this.sufixIcon,
    this.subIcon,
    required this.title,
    required this.subtitle,
    required this.hasAction,
    this.check,
    required this.checkBox,
    this.onTapCheckBox,
    this.onTapSubIcon,
    this.onTapSufixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        prefixIcon ?? const SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StyleLabel(
              title: title,
              style: ThemeText.note.copyWith(height: 2, color: AppColor.primaryColor),
            ),
            Row(
              children: [
                StyleLabel(
                  title: subtitle,
                  style: ThemeText.body2.copyWith(height: 1.5),
                ),
                subIcon != null ? subIcon.onTap(onTapSubIcon) : const SizedBox()
              ],
            )
          ],
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall).expand(),
        checkBox
            ? Icon(
                check!
                ? Icons.cancel_outlined
                : Icons.check_circle_outline_sharp,
                color: check!
                      ? AppColor.cancelColor
                      : AppColor.green,
                size: AppDimens.iconMediumSize,
              ).paddingRight(AppDimens.paddingMedium).onTap(onTapCheckBox)
            : const SizedBox(),
        sufixIcon != null ? sufixIcon.onTap(onTapSufixIcon) :
            (hasAction == true
                ? ImageAppWidget(
                    height: 24.h,
                    path: Assets.images.icArrowRight2.keyName,
                    color: AppColor.primaryColor,
                  ).paddingRight(4.w).onTap(onTapSufixIcon)
                : const SizedBox())
      ],
    );
  }
}

//Component toggle
class ToggleButtonStyle extends StatelessWidget {
  final Widget? prefixIcon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final bool hasAction;
  final bool checkBox;
  final bool toggleValue;
  const ToggleButtonStyle({
    Key? key,
    this.prefixIcon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.toggleValue,
    this.hasAction = true,
    this.checkBox = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFormView(
      child: FormChildToggleButtonStyle(
        prefixIcon: prefixIcon,
        title: title,
        subtitle: subtitle,
        hasAction: hasAction,
        checkBox: checkBox,
        toggleValue: toggleValue,
      ),
    ).onTap(() => onPressed()).paddingBottom(AppDimens.paddingSmall);
  }
}

class FormChildToggleButtonStyle extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final String title;
  final String subtitle;
  final bool hasAction;
  final bool checkBox;
  final bool toggleValue;
  const FormChildToggleButtonStyle({
    Key? key,
    this.prefixIcon,
    this.sufixIcon,
    required this.title,
    required this.subtitle,
    required this.hasAction,
    required this.checkBox,
    required this.toggleValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        prefixIcon ?? const SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            StyleLabel(
              title: title,
              style: ThemeText.body2,
            ),
            StyleLabel(
              title: subtitle,
              style: ThemeText.note.copyWith(height: 2),
              maxLines: 2,
            ),
          ],
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall).expand(),
        checkBox
            ? Icon(
                Icons.check_circle_outline_sharp,
                color: AppColor.green,
                size: AppDimens.iconMediumSize,
              ).paddingRight(AppDimens.paddingMedium)
            : const SizedBox(),
        sufixIcon ??
            (hasAction == true
                ? ImageAppWidget(
                    height: 12.h,
                    path: Assets.images.icArrowRight2.keyName,
                    color: AppColor.primaryColor,
                  )
                : const SizedBox()),
        SwitchApp(
          toggleValue: toggleValue,
        ),
      ],
    );
  }
}
