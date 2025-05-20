// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/themes/theme_text.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/text_widget/style_lable.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/ui/dash_board/components/card_view.dart';

import '../../../common/themes/themes.dart';

class TransactionItemList extends StatelessWidget {
  final TransactionItemEntity transaction;
  const TransactionItemList({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(
          TransactionDetailRoute(transactionId: transaction.transactionCoinId)),
      child: CardFormView(
          child: Row(
        children: [
          SizedBox(width: 5.w),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StyleLabel(
                  title: transaction.description,
                  style:
                      ThemeText.caption.copyWith(fontWeight: FontWeight.bold),
                ).paddingBottom(AppDimens.paddingSmall),
                StyleLabel(
                  title: transaction.updateTime,
                  style: ThemeText.note.copyWith(fontSize: 11.sp, color: AppColor.primaryColor, fontWeight: FontWeight.w300),
                ),
              ]).expand(),
          StyleLabel(
            title: transaction.amount > 0
                ? '+ ${transaction.amount} coin'
                : '${transaction.amount} coin',
            style: ThemeText.caption.copyWith(fontWeight: FontWeight.bold),
          ).paddingRight(AppDimens.paddingSmall),
          ImageAppWidget(
            path: Assets.images.icArrowRight2.keyName,
            height: AppDimens.iconMediumSize,
          ).paddingRight(AppDimens.paddingVerySmall)
        ],
      )),
    );
  }
}
