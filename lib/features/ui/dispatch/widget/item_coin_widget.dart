// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/features/domain/enterties/dispatch/analyst_angency_entity.dart';
import 'package:pipcar/features/ui/dash_board/components/card_view.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';

class BlockListSalaryDriver extends StatefulWidget {
  final AnalystExpenseEntity analystExpense;
  const BlockListSalaryDriver({
    Key? key,
    required this.analystExpense,
  }) : super(key: key);

  @override
  State<BlockListSalaryDriver> createState() => _BlockListSalaryDriverState();
}

class _BlockListSalaryDriverState extends State<BlockListSalaryDriver> {
  bool isHideList = true;

  @override
  Widget build(BuildContext context) {
    return CardFormView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 0, color: AppColor.lightGrey),
            if (!isHideList) ..._buildItemSalary(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isHideList
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.keyboard_arrow_up_rounded,
                  color: AppColor.primaryColor,
                ),
              ],
            ).onTap(() {
              setState(() => isHideList = !isHideList);
            }).paddingSymmetric(vertical: 2.h)
          ],
        ));
  }

  _buildHeader(BuildContext context) {
    return Row(
      children: [
        ImageAppWidget(
          path: Assets.icons.iconWallet.keyName,
          width: 25.w,
          color: AppColor.primaryColor,
        ).paddingSymmetric(horizontal: 5.w),
        StyleLabel(
                title: 'Chi lương lái xe',
                style: ThemeText.caption.copyWith(fontSize: 14.sp))
            .expand(),
        StyleLabel(
                title: "${widget.analystExpense.totalSalary} coin",
                style: ThemeText.caption
                    .copyWith(fontSize: 14.sp, fontWeight: FontType.bold))
            .paddingSymmetric(horizontal: 5.w)
      ],
    ).paddingSymmetric(vertical: 20.h, horizontal: 5.w);
  }

  List<Widget> _buildItemSalary(BuildContext context) {
    return List.generate(
        widget.analystExpense.driverSalaryList.length,
        (index) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.share_outlined,
                      color: AppColor.primaryColor,
                    ).paddingSymmetric(horizontal: 6.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleLabel(
                            title: widget.analystExpense.driverSalaryList[index]
                                .driverName,
                            style: ThemeText.caption.copyWith(fontSize: 13.sp)),
                        StyleLabel(
                            title: widget.analystExpense.driverSalaryList[index]
                                .driverPhone,
                            style: ThemeText.caption.copyWith(
                              fontSize: 17.sp,
                              fontWeight: FontType.bold,
                            ))
                      ],
                    ).expand(),
                    StyleLabel(
                            title:
                                "${widget.analystExpense.driverSalaryList[index].driverSalary} coin",
                            style: ThemeText.caption.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontType.bold,
                                color: AppColor.errorColor))
                        .paddingSymmetric(horizontal: 5.w)
                  ],
                ).paddingSymmetric(vertical: 10.h, horizontal: 5.w),
                const Divider(height: 0, color: AppColor.lightGrey)
              ],
            ));
  }
}

class ItemCoinWidget extends StatelessWidget {
  final Widget? prefixIcon;
  final String? title;
  final String? subTitle;
  final double? coin;
  const ItemCoinWidget({
    Key? key,
    this.prefixIcon,
    this.title,
    this.subTitle,
    this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFormView(
        child: Row(
      children: [
        (prefixIcon ?? const SizedBox()).paddingSymmetric(horizontal: 5.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) StyleLabel(title: title ?? ''),
            StyleLabel(
                title: subTitle ?? '',
                style: ThemeText.caption.copyWith(fontSize: 14.sp))
          ],
        ).expand(),
        StyleLabel(
                title: "$coin coin",
                style: ThemeText.caption
                    .copyWith(fontSize: 14.sp, fontWeight: FontType.bold))
            .paddingSymmetric(horizontal: 5.w)
      ],
    )).paddingBottom(10.h);
  }
}
