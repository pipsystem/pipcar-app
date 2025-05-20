import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';

import '../../core/presentation/widgets/widgets.dart';
import '../configs/constants/app_dimens.dart';
import '../themes/themes.dart';

enum DialogType { announce, option }

mixin DialogsMixin {
  showAlertDialog({
    required BuildContext context,
    required DialogType type,
    String? title,
    String? mainMessage,
    String? message,
    String? buttonTitle,
    String? textTransfer,
    VoidCallback? settingAction,
    VoidCallback? acceptAction,
    VoidCallback? denyAction,
  }) {
    int styleDialog = LocalStorage.accessToken.val != "" ? 2 : 1;

    Widget inforWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimens.borderSmall),
              topRight: Radius.circular(AppDimens.borderSmall),
            ),
          ),
          child: StyleLabel(
            title: title?.toUpperCase() ?? translate("announce").toUpperCase(),
            textAlign: TextAlign.center,
            style: ThemeText.subtitle1.copyWith(fontSize: 20.sp),
          ).paddingSymmetric(vertical: AppDimens.paddingSmall),
        ),
        Container(
            width: double.infinity,
            constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height * 0.3),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.white),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimens.borderSmall),
                bottomRight: Radius.circular(AppDimens.borderSmall),
              ),
            ),
            child: Column(
              children: [
                mainMessage != null 
                ? StyleLabel(
                  title: mainMessage,
                  textAlign: TextAlign.center,
                  style: ThemeText.caption.copyWith(color: AppColor.white, fontSize: 20.sp),
                  maxLines: 100,
                ).paddingAll(AppDimens.paddingMedium)
                : const Column(),
                StyleLabel(
                  title: message ?? "message",
                  textAlign: TextAlign.center,
                  style: ThemeText.caption.copyWith(color: AppColor.white),
                  maxLines: 100,
                ).paddingAll(AppDimens.paddingMedium),
                GestureDetector(
                  child: StyleLabel(
                    title: textTransfer ?? "",
                    textAlign: TextAlign.center,
                    style: ThemeText.caption.copyWith(color: AppColor.white, decoration: TextDecoration.underline, decorationColor: AppColor.white),
                    maxLines: 100,
                  ).paddingTop(50.h),
                  onTap: () {
                    if(settingAction != null) {
                      context.pop();
                      settingAction();
                    }
                  },
                )
              ],
            )
          ),
      ],
    );

    Widget actionWidget = ((acceptAction == null && denyAction == null && settingAction == null) || (acceptAction != null))
    ? (type == DialogType.announce
        ? TextButtonWidget(
            onPressed: () {
              context.pop();
              if (acceptAction != null) acceptAction();
            },
            title: buttonTitle ?? "OK",
          ).paddingSymmetric(vertical: AppDimens.paddingSmall)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                onPressed: () {
                  context.pop();
                  if (acceptAction != null) acceptAction();
                },
                title: buttonTitle ?? "Đồng ý",
              ).expand(),
              AppDimens.sizedBoxWidth10,
              TextButtonWidget(
                onPressed: () {
                  denyAction == null ? context.pop() : denyAction();
                },
                title: translate("no"),
                buttonColor: AppColor.paleGrey,
                titleColor: AppColor.black,
                borderColor: AppColor.paleGrey,
              ).expand(),
            ],
          ))
    : SizedBox(); 

    Widget inforWidget2 = Column(
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
            title: title?.toUpperCase() ?? translate("announce").toUpperCase(),
            textAlign: TextAlign.center,
            style: ThemeText.subtitle1
                .copyWith(fontSize: 20.sp, color: AppColor.white),
          ).paddingSymmetric(vertical: AppDimens.paddingSmall),
        ),
        Container(
            width: double.infinity,
            constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height * 0.3),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primaryColor),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimens.borderSmall),
                bottomRight: Radius.circular(AppDimens.borderSmall),
              ),
            ),
            child: Column(
              children: [
                mainMessage != null 
                ? StyleLabel(
                  title: mainMessage,
                  textAlign: TextAlign.center,
                  style: ThemeText.caption.copyWith(fontSize: 20.sp),
                  maxLines: 100,
                ).paddingAll(AppDimens.paddingMedium)
                : const Column(),
                StyleLabel(
                  title: message ?? "message",
                  textAlign: TextAlign.center,
                  style: ThemeText.caption.copyWith(height: 1.5),
                  maxLines: 100,
                ).paddingAll(AppDimens.paddingMedium),
                GestureDetector(
                  child: StyleLabel(
                    title: textTransfer ?? "",
                    textAlign: TextAlign.center,
                    style: ThemeText.caption.copyWith(decoration: TextDecoration.underline),
                    maxLines: 100,
                  ).paddingTop(50.h),
                  onTap: () {
                    if(settingAction != null) {
                      context.pop();
                      settingAction();
                    }
                  },
                )
              ],
            ),
            ),
      ],
    );

    Widget actionWidget2 = ((acceptAction == null && denyAction == null && settingAction == null) || (acceptAction != null))
    ? (type == DialogType.announce
        ? TextButtonWidget(
            onPressed: () {
              context.pop();
              if (acceptAction != null) acceptAction();
            },
            title: buttonTitle ?? "OK",
            titleColor: AppColor.white,
            buttonColor: AppColor.primaryColor,
          ).paddingSymmetric(vertical: AppDimens.paddingSmall)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                onPressed: () {
                  context.pop();
                  if (acceptAction != null) acceptAction();
                },
                title: buttonTitle ?? "Đồng ý",
                titleColor: AppColor.white,
                buttonColor: AppColor.primaryColor,
              ).expand(),
              AppDimens.sizedBoxWidth10,
              TextButtonWidget(
                onPressed: () {
                  denyAction == null ? context.pop() : denyAction();
                },
                title: translate("no"),
                buttonColor: AppColor.borderCard,
                titleColor: AppColor.primaryColor,
                borderColor: AppColor.borderCard,
              ).expand(),
            ],
          ))
    : SizedBox(); 

    styleDialog == 1
        ? showGeneralDialog(
            barrierLabel: "Barrier",
            barrierDismissible: (textTransfer == null && buttonTitle == null),
            transitionDuration: const Duration(milliseconds: 300),
            context: context,
            pageBuilder: (_, __, ___) {
              return Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    ImageAppWidget(
                      path: Assets.images.background.keyName,
                      fit: BoxFit.cover,
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                    ).onTap(() => textTransfer == null ? context.pop() : null),
                    Align(
                      alignment: Alignment.center,
                      child: IntrinsicHeight(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: inforWidget
                                    .paddingBottom(AppDimens.paddingMedium),
                              ),
                              actionWidget,
                            ],
                          ),
                        ).paddingSymmetric(
                            horizontal: AppDimens.paddingVeryLarge),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : showGeneralDialog(
            barrierLabel: "Barrier",
            barrierDismissible: (textTransfer == null && buttonTitle == null),
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
                          child: inforWidget2
                              .paddingBottom(AppDimens.paddingMedium),
                        ),
                        actionWidget2,
                      ],
                    ),
                  ).paddingSymmetric(horizontal: AppDimens.paddingVeryLarge),
                ),
              );
            },
          );
  }
}
