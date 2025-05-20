import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/transation/transaction_details/cubit/transaction_detail_cubit.dart';

import '../../../../../../../common/themes/themes.dart';
import '../../../../../../../core/presentation/widgets/widgets.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String transactionId;
  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  void initState() {
    context.read<TransactionDetailCubit>().getData(widget.transactionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: "Chi tiết giao dịch",
          titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 27.h),
            StyleLabel(
                    title: "Giao dịch",
                    style: ThemeText.caption
                        .copyWith(fontWeight: FontType.bold, fontSize: 16.sp))
                .paddingBottom(8.h),
            BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
              builder: (context, state) {
                if (state.status != TransactionDetailStatus.loaded) {
                  return SizedBox(
                    height: 200.h,
                    width: 1.sw * 0.9,
                    child: const ShimmerLoading(),
                  );
                }
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimens.borderSmall),
                      border:
                          Border.all(color: AppColor.hintColor, width: 0.5)),
                  child: Column(
                    children: [
                      _horizontalInfor(
                          "Ngày thực hiện", state.detail!.updateTime),
                      Divider(height: 0, color: AppColor.dividerColor),
                      _horizontalInfor(
                          "Số coin", "${state.detail!.amount.abs()} coin"),
                      Divider(height: 0, color: AppColor.dividerColor),
                      _horizontalInfor(
                          "Số dư", '${state.detail!.balance} coin'),
                      Divider(height: 0, color: AppColor.dividerColor),
                      _horizontalInfor("Trạng thái", "Thành công"),
                      Divider(height: 0, color: AppColor.dividerColor),
                      _horizontalInfor("Nội dung", state.detail!.description),
                    ],
                  ).paddingLeft(5.w),
                );
              },
            ),
            const Spacer(),
            // Visibility(
            //   visible: context.watch<TransactionDetailCubit>().state.detail !=
            //           null &&
            //       context.watch<TransactionDetailCubit>().state.detail?.type !=
            //           1,
            //   child: TextButtonWidget(
            //           titleColor: AppColor.white,
            //           buttonColor: AppColor.primaryColor,
            //           onPressed: () {
            //             DetailsTicketTransaction(
            //                     detail: context
            //                         .read<TransactionDetailCubit>()
            //                         .state
            //                         .detail!)
            //                 .launch(context);
            //           },
            //           title: 'Xem lịch')
            //       .paddingSymmetric(vertical: AppDimens.paddingMedium),
            // )
          ],
        ).paddingSymmetric(
            vertical: AppDimens.paddingVerticalApp,
            horizontal: AppDimens.paddingHorizontalApp));
  }

  Widget _horizontalInfor(String title, String content) {
    return Row(
      children: [
        StyleLabel(
          title: title,
          style: ThemeText.note.copyWith(fontWeight: FontWeight.w400),
        ).paddingRight(37.w),
        StyleLabel(
          title: content,
          maxLines: 100,
          textAlign: TextAlign.end,
          style: ThemeText.note.copyWith(fontWeight: FontWeight.w400),
        ).expand()
      ],
    ).paddingSymmetric(vertical: 14.h);
  }
}
