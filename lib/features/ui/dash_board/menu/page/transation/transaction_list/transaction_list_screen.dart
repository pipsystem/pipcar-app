// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/widgets/transaction_item_list.dart';

import 'package:pipcar/features/ui/dash_board/menu/page/transation/transaction_list/cubit/transaction_list_cubit.dart';

import '../../../../../../../common/assets/assets.gen.dart';
import '../../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../../common/themes/themes.dart';
import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../schedule/widgets/empty_schedule.dart';
import '../../../../../schedule/widgets/load_more_widget.dart';
import '../../../../components/card_view.dart';

class TransactionListScreen extends StatefulWidget {
  final int currentCoin;
  const TransactionListScreen({
    Key? key,
    required this.currentCoin,
  }) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          context.read<TransactionListCubit>().getListTransaction();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Lịch sử coin",
        titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              ButtonStyle2(
                  hasAction: false,
                  prefixIcon: ImageAppWidget(
                    height: AppDimens.buttonIconSize,
                    path: Assets.images.icCoin.keyName,
                    color: AppColor.primaryColor,
                  ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
                  title: "Coin",
                  subtitle: "${widget.currentCoin}",
                  onPressed: () {}),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Icon(Icons.add_circle_outline_outlined,
              //         color: AppColor.primaryColor, size: 40.h),
              //     SizedBox(width: 10.w),
              //     Icon(Icons.remove_circle_outline_outlined,
              //         color: AppColor.grey, size: 40.h),
              //     SizedBox(width: 8.w)
              //   ],
              // )
            ],
          ),
          AppDimens.sizedBoxHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StyleLabel(title: "Tất cả", style: ThemeText.smallTextTicket),
              Icon(Icons.filter_list_sharp,
                  color: AppColor.primaryColor, size: 25.sp)
            ],
          ),
          BlocBuilder<TransactionListCubit, TransactionListState>(
            builder: (context, state) {
              if (state.status == TransactionListStatus.loadFirst) {
                return ListView.builder(
                    itemCount: 5,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => SizedBox(
                            height: 1.sh * 0.1,
                            width: double.infinity,
                            child: const ShimmerLoading())
                        .paddingSymmetric(vertical: 5)).expand();
              }
              return RefreshIndicator(
                onRefresh: () => context
                    .read<TransactionListCubit>()
                    .getListTransaction(isOnRefresh: true),
                child: state.transactions.isEmpty
                    ? const EmptyListSchedule(
                        text: 'Lịch sử giao dịch trống',
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding:
                            const EdgeInsets.only(top: AppDimens.paddingSmall),
                        itemCount: state.transactions.length +
                            (state.status == TransactionListStatus.loadMore
                                ? 1
                                : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.transactions.length) {
                            // Timer(const Duration(milliseconds: 30), () {
                            //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                            // });
                            return const LoadMoreCircular();
                          } else {
                            return TransactionItemList(
                              transaction: state.transactions[index],
                            ).paddingBottom(AppDimens.paddingVerySmall);
                          }
                        }),
              ).expand();
            },
          ),
        ],
      ).paddingSymmetric(
          vertical: AppDimens.paddingVerticalApp,
          horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}
