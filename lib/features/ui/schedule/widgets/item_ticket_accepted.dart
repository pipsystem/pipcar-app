import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/accepted_list/details_accepted/cubit/details_accepted_cubit.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/enterties/entities.dart';
import '../../dash_board/components/card_view.dart';
import 'card_view_blue.dart';

class ItemTicketAccepted extends StatelessWidget {
  final TicketOwnerAcceptedEntity ticket;
  final bool fullContent;
  const ItemTicketAccepted(
      {super.key, required this.ticket, this.fullContent = true});

  @override
  Widget build(BuildContext context) {
    return CardFormView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ImageAppWidget(
                path: ticket.ownerAvatar,
                fit: BoxFit.cover,
                width: 25.w,
              ),
            ).paddingRight(10.w),
            StyleLabel(
                    title: ticket.ownerName,
                    style: ThemeText.mediumTextTicket
                        .copyWith(fontWeight: FontType.bold),
                    maxLines: 100)
                .expand(),
          ],
        ).paddingAll(2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyleLabel(
                title: ticket.description,
                style: ThemeText.mediumTextTicket
                    .copyWith(fontWeight: FontType.bold),
                maxLines: fullContent ? 100 : 5),
            SizedBox(height: 6.h),
            _horizontalTextView(
                title: "Thời gian đón", content: ticket.pickupTime),
            SizedBox(height: 6.h),
            Wrap(
              children: [
                CardViewBlue(
                  title: ticket.carTypeName,
                  prefixIcon: ImageAppWidget(
                    path: Assets.images.xe5.keyName,
                    width: 32.w,
                  ),
                ).paddingRight(5.w),
                CardViewBlue(
                  title: ticket.coin == 0 ? "Free" : "${ticket.coin} coin",
                  prefixIcon: ImageAppWidget(
                    path: Assets.images.icCoin.keyName,
                    width: 14.w,
                  ),
                ).paddingRight(5.w),
                CardViewBlue(
                  title: ticket.statusName,
                ).paddingRight(5.w),
              ],
            ),
          ],
        ).paddingAll(6)
      ],
    ))    ;
  }

  Widget _scrollTextView({required String title, required String content}) {
    return Row(
      children: [
        StyleLabel(
          title: "$title : ",
          style: ThemeText.smallTextTicket.copyWith(color: AppColor.hintColor),
        ),
        Flexible(
          child: TextScroll(
            content,
            mode: TextScrollMode.endless,
            style: ThemeText.smallTextTicket,
            pauseBetween: Duration(milliseconds: 500),
          ),
        ),
      ],
    );
  }

  Widget _horizontalTextView({required String title, required String content}) {
    return Row(
      children: [
        StyleLabel(
          title: "$title : ",
          style: ThemeText.smallTextTicket.copyWith(color: AppColor.hintColor),
        ),
        StyleLabel(
          title: content,
          style: ThemeText.smallTextTicket,
        )
      ],
    );
  }
}

class FormEditInforCustomer {
  static showFormEdit(BuildContext context) async {
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
              value: context.read<DetailsAcceptedCubit>(), //blocCarList,
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
                            title: "Khách hàng",
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
                                        .read<DetailsAcceptedCubit>()
                                        .nameCustomerController,
                                    borderColor: AppColor.hintColor,
                                    hintText: "Tên khách hàng",
                                    hintStyle: ThemeText.caption
                                        .copyWith(color: AppColor.hintColor),
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
                                        .read<DetailsAcceptedCubit>()
                                        .phoneCustomerController,
                                    borderColor: AppColor.hintColor,
                                    hintText: "Số điện thoại",
                                    hintStyle: ThemeText.caption
                                        .copyWith(color: AppColor.hintColor),
                                    textStyle: ThemeText.caption,
                                    keyboardType: TextInputType.phone,
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
                            context
                                .read<DetailsAcceptedCubit>()
                                .updateTicketCustomer();
                          }
                        },
                        title: "Cập nhật",
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
