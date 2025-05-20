import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/service/text_to_speech/flutter_tts.dart';
import '../../dash_board/components/card_view.dart';
import 'card_view_blue.dart';

class ItemSupplierSchedule extends StatelessWidget {
  final TicketSupplierEntity ticket;
  final bool showStatusName;
  final bool isShowTts;
  final bool fullContent;
  final VoidCallback? onDeleteTicketNavigate;
  const ItemSupplierSchedule(
      {super.key,
      required this.ticket,
      this.showStatusName = true,
      this.isShowTts = true,
      this.onDeleteTicketNavigate,
      this.fullContent = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CardFormView(
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
                ).paddingRight(5.w),
                StyleLabel(
                        title: ticket.ownerName,
                        style: ThemeText.mediumTextTicket
                            .copyWith(fontWeight: FontType.bold),
                        maxLines: 100)
                    .expand(),
              ],
            ).paddingBottom(4.h),
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
                Visibility(
                  visible: ticket.isNavigate &&
                      onDeleteTicketNavigate != null &&
                      fullContent,
                  child: _scrollTextView(
                          title: "Khu vực đến",
                          content:
                              "${ticket.dropOffDistrictName}, ${ticket.dropOffProvinceName}      ")
                      .paddingBottom(6.h),
                ),
                Visibility(
                  visible: ticket.isNavigate && onDeleteTicketNavigate != null,
                  child: _horizontalTextView(
                          title: "Thời gian đến", content: ticket.dropOffTime)
                      .paddingBottom(6.h),
                ),
                Wrap(
                  children: [
                    CardViewBlue(
                      title: ticket.carTypeName,
                      prefixIcon: ImageAppWidget(
                        path: Assets.images.xe5.keyName,
                        width: 32.w,
                      ),
                    ).paddingRight(5.w),
                    Visibility(
                      visible: !ticket.isNavigate,
                      child: CardViewBlue(
                        title: ticket.coin == 0 ? "Free" : "${ticket.coin} coin",
                        prefixIcon: ImageAppWidget(
                          path: Assets.images.icCoin.keyName,
                          width: 14.w,
                        ),
                      ).paddingRight(5.w),
                    ),
                    Visibility(
                      visible: ticket.isNavigate,
                      child: CardViewBlue(
                        prefixIcon: ImageAppWidget(
                          path: Assets.images.iconPathGrey.keyName,
                          width: 14.w,
                        ),
                        title: "Điều hướng",
                      ).paddingRight(5.w),
                    ),
                    Visibility(
                      visible: showStatusName && !ticket.isNavigate,
                      child: CardViewBlue(
                        title: ticket.statusName,
                      ).paddingRight(5.w),
                    ),
                  ],
                )
              ],
            ).paddingAll(4),
          ],
        ).paddingAll(2)),
        Positioned.fill(
            child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: ticket.isNavigate && onDeleteTicketNavigate != null,
                child: Icon(
                  Icons.delete_outline,
                  color: AppColor.errorColor,
                  size: 28.sp,
                ).onTap(onDeleteTicketNavigate).paddingRight(10.w),
              ),
              Visibility(
                visible: isShowTts,
                child: ImageAppWidget(
                        path: Assets.images.volumeUp.keyName,
                        width: 28,
                        height: 28).paddingBottom(AppDimens.paddingSmall)
                    .onTap(() => FlutterTtsService.speak(ticket.speech())),
              ),
            ],
          ),
        ).paddingAll(AppDimens.paddingMedium)),
      ],
    );
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
        Expanded(
            child: StyleLabel(
          title: content,
          style: ThemeText.smallTextTicket,
          maxLines: 2,
        ))
      ],
    );
  }
}
