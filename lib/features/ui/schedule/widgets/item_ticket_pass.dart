import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/enterties/ticket/ticket_owner_pass.dart';
import '../../dash_board/components/card_view.dart';
import 'card_view_blue.dart';

class ItemTicketPass extends StatelessWidget {
  final TicketOwnerPassEntity ticket;
  final bool fullContent;
  const ItemTicketPass(
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
                Visibility(
                  visible: ticket.waitCount != 0,
                  child: CardViewBlue(
                    title: ticket.waitCount < 10 ? "Có 0${ticket.waitCount} xe bổ" : "Có ${ticket.waitCount} xe bổ",
                  ).paddingRight(5.w),
                ),
              ],
            ),
          ],
        ).paddingAll(6)
      ],
    ));
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
