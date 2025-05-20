// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/features/domain/enterties/transaction/transaction_detail_entity.dart';

import '../../../../../../../common/assets/assets.gen.dart';
import '../../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../../common/themes/themes.dart';
import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../schedule/widgets/card_view_blue.dart';
import '../../../../components/card_view.dart';

enum TicketType {
  applying,
}

class DetailsTicketTransaction extends StatelessWidget {
  final TransactionDetailEntity detail;
  const DetailsTicketTransaction({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          ItemTicketInfor(ticket: detail.ticketInfor),
        ],
      ),
    );
  }
}

class ItemTicketInfor extends StatelessWidget {
  final TicketInforEntity ticket;
  final bool showStatusName;
  const ItemTicketInfor(
      {super.key, required this.ticket, this.showStatusName = true});

  @override
  Widget build(BuildContext context) {
    return CardFormView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
            title: ticket.description,
            style:
                ThemeText.mediumTextTicket.copyWith(fontWeight: FontType.bold),
            maxLines: 100),
        SizedBox(height: 5.h),
        _horizontalTextView(
            title: "Khu vực đón",
            content:
                "${ticket.pickupDistrictName}, ${ticket.pickupProvinceName}"),
        SizedBox(height: 5.h),
        _horizontalTextView(title: "Thời gian đón", content: ticket.pickupTime),
        SizedBox(height: 5.h),
        Row(
          children: [
            CardViewBlue(
              title: ticket.carTypeName,
              prefixIcon: ImageAppWidget(
                path: Assets.images.xe5.keyName,
                width: 32.w,
              ),
            ).paddingRight(5.w),
            CardViewBlue(
              title: "${ticket.coin} coin",
              prefixIcon: ImageAppWidget(
                path: Assets.images.icCoin.keyName,
                width: 14.w,
              ),
            ).paddingRight(5.w),
            Visibility(
              visible: showStatusName,
              child: CardViewBlue(
                title: ticket.statusName,
              ).paddingRight(5.w),
            ),
          ],
        )
      ],
    ).paddingAll(AppDimens.paddingMedium));
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
