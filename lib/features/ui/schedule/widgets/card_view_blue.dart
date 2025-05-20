import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../common/assets/assets.gen.dart';
import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../dash_board/components/card_view.dart';

class CardViewBlue extends StatelessWidget {
  final Widget? prefixIcon;
  final String title;
  const CardViewBlue({super.key, this.prefixIcon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(
        color: AppColor.lightBlue,
        borderRadius: BorderRadius.circular(AppDimens.borderSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          prefixIcon ?? const SizedBox(),
          prefixIcon != null ? AppDimens.sizedBoxWidth10 : const SizedBox(),
          StyleLabel(
            title: title,
            style: ThemeText.noteSmall.copyWith(fontWeight: FontType.regular),
          )
        ],
      ).paddingAll(10),
    );
  }
}

class ButtonInforTicket extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;
  final String? buttonTitle;
  final VoidCallback? onButtonCall;
  final Widget? iconButton;
  final Widget? prefixIcon;
  const ButtonInforTicket({
    super.key,
    required this.title,
    required this.subtitle,
    required this.label,
    this.buttonTitle,
    this.onButtonCall,
    this.iconButton,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: label,
          style: ThemeText.body2.copyWith(
            color: AppColor.primaryColor,
          ),
        ).paddingBottom(AppDimens.paddingSmall),
        Stack(
          children: [
            ButtonStyle2(
                hasAction: false,
                prefixIcon: prefixIcon ??
                    ImageAppWidget(
                      height: AppDimens.buttonIconSize,
                      path: Assets.images.icPerson.keyName,
                      color: AppColor.primaryColor,
                    ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
                title: title,
                subtitle: subtitle,
                onPressed: () {}),
            Visibility(
              visible: buttonTitle != null,
              child: Positioned.fill(
                  child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onButtonCall,
                  child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.hintColor, width: 0.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Wrap(children: [
                            iconButton?.paddingRight(AppDimens.paddingSmall) ??
                                const SizedBox(),
                            StyleLabel(
                              title: buttonTitle ?? "",
                              style: ThemeText.body2
                                  .copyWith(fontWeight: FontType.medium),
                            ),
                          ]).paddingAll(AppDimens.paddingSmall))
                      .paddingRight(AppDimens.paddingMedium),
                ),
              )),
            )
          ],
        ),
      ],
    );
  }
}
