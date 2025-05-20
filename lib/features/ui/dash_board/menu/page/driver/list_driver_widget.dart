import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/features/domain/enterties/agency/driver_item_list_entity.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/driver/cubit/list_driver_cubit.dart';

import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';
import '../../../components/card_view.dart';
import 'list_driver_strings.dart';

class DriverHasCarWidget extends StatelessWidget {
  final DriverItemListEntity driver;
  const DriverHasCarWidget({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return CardFormView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 12,
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 12,
                child: FormChildButtonStyle2(
                  prefixIcon: ImageAppWidget(
                    height: AppDimens.buttonIconSize,
                    path: Assets.images.icPerson.keyName,
                    color: AppColor.primaryColor,
                  ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
                  title: driver.name,
                  subtitle: driver.phone,
                  checkBox: false,
                  hasAction: false,
                  // sufixIcon: Icon(
                  //   Icons.keyboard_arrow_down_outlined,
                  //   color: AppColor.primaryColor,
                  //   size: AppDimens.iconMediumSize,
                  // ),
                )),
          ),
          Divider(
            color: AppColor.dividerColor,
            thickness: 1,
          ),
          SizedBox(
              height: MediaQuery.sizeOf(context).height / 12,
              child: FormChildButtonStyle2(
                prefixIcon: ImageAppWidget(
                  height: AppDimens.buttonIconSize,
                  path: Assets.images.icCars.keyName,
                  color: AppColor.primaryColor,
                ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
                title: driver.carInfor!.name,
                subtitle: driver.carInfor!.plates,
                checkBox: false,
                hasAction: false,
                // sufixIcon: Icon(
                //   Icons.delete_outline,
                //   color: AppColor.hintColor,
                // ).onTap(() => context.read<ListDriverCubit>().undeliverCar(driver.driverId)),
              )),
        ],
      ),
    ).paddingBottom(AppDimens.paddingMedium);
  }
}

class FormDriverWidget {
  static showFormAdd(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    return await showDialog(
        barrierColor: AppColor.white,
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: true,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColor.white, // AppColor.white,
            titlePadding: EdgeInsets.zero,
            content: BlocProvider.value(
              value: context.read<ListDriverCubit>(), //blocCarList,
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
                            title: ListDriverStrings.addDriver,
                            textAlign: TextAlign.center,
                            style: ThemeText.subtitle1.copyWith(
                                fontSize: 20.sp, color: AppColor.white),
                          ).paddingSymmetric(vertical: AppDimens.paddingSmall),
                        ),
                        Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.sizeOf(context).height * 0.4),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(AppDimens.borderSmall),
                                bottomRight:
                                    Radius.circular(AppDimens.borderSmall),
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    controller: context
                                        .read<ListDriverCubit>()
                                        .nameDriverController,
                                    borderColor: AppColor.hintColor,
                                    hintText: ListDriverStrings.nameDriver,
                                    textStyle: ThemeText.caption,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Tên lái xe không được để trống";
                                      }
                                      return null;
                                    },
                                    prefixIcon: ImageAppWidget(
                                      height: 10,
                                      path: Assets.images.icPerson.keyName,
                                    ).paddingAll(AppDimens.paddingMedium),
                                  ).paddingBottom(AppDimens.paddingMedium),
                                  TextFieldWidget(
                                    controller: context
                                        .read<ListDriverCubit>()
                                        .phoneDriverController,
                                    borderColor: AppColor.hintColor,
                                    hintText: ListDriverStrings.phoneDriver,
                                    textStyle: ThemeText.caption,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return translate("phone_empty");
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(
                                        Icons.phone_android_sharp,
                                        color: AppColor.primaryColor),
                                  ).paddingBottom(AppDimens.paddingMedium),
                                ],
                              ).paddingAll(AppDimens.paddingMedium),
                            )),
                      ],
                    ).paddingBottom(AppDimens.paddingMedium),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButtonWidget(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            context.router.pop();
                            context.read<ListDriverCubit>().addDriver();
                          }
                        },
                        title: translate("add"),
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
            ),
          );
        });
  }
}
