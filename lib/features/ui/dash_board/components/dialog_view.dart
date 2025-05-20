import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class DialogConfirmDelete {
  static showConfirmDelete(BuildContext context, String message) async {
    return await showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: AppColor.white,
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: IntrinsicHeight(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppDimens.borderSmall),
                              topRight: Radius.circular(AppDimens.borderSmall),
                            ),
                          ),
                          child: StyleLabel(
                            title: translate("announce").toUpperCase(),
                            textAlign: TextAlign.center,
                            style: ThemeText.subtitle1.copyWith(fontSize: 20.sp, color: AppColor.white),
                          ).paddingSymmetric(vertical: AppDimens.paddingSmall),
                        ),
                        Container(
                            width: double.infinity,
                            constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height * 0.3),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(AppDimens.borderSmall),
                                bottomRight: Radius.circular(AppDimens.borderSmall),
                              ),
                            ),
                            child: StyleLabel(
                              title: message,
                              textAlign: TextAlign.center,
                              style: ThemeText.caption,
                              maxLines: 5,
                            ).paddingAll(AppDimens.paddingMedium)),
                      ],
                    ).paddingBottom(AppDimens.paddingMedium),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButtonWidget(
                        onPressed: () => context.router.pop(true),
                        title: "Đồng ý",
                        titleColor: AppColor.white,
                        buttonColor: AppColor.primaryColor,
                      ).expand(),
                      AppDimens.sizedBoxWidth10,
                      TextButtonWidget(
                        onPressed: () => context.router.pop(false),
                        title: translate("no"),
                        buttonColor: AppColor.borderCard,
                        titleColor: AppColor.primaryColor,
                        borderColor: AppColor.borderCard,
                      ).expand(),
                    ],
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: AppDimens.paddingVeryLarge),
          ),
        );
      },
    );
  }
}
