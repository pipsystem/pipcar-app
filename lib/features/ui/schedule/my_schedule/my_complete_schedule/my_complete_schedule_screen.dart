// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../core/presentation/routers/app_router.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../widgets/empty_schedule.dart';
import '../../widgets/item_supplier_schedule.dart';
import '../../widgets/load_more_widget.dart';
import 'cubit/my_complete_schedule_cubit.dart';

class MyCompleteScheduleScreen extends StatefulWidget {
  final DriverDeleveringEntity? driver;
  const MyCompleteScheduleScreen({
    Key? key,
    this.driver,
  }) : super(key: key);

  @override
  State<MyCompleteScheduleScreen> createState() =>
      _MyCompleteScheduleScreenState();
}

class _MyCompleteScheduleScreenState extends State<MyCompleteScheduleScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    context
        .read<MyCompleteScheduleCubit>()
        .getMyCompleteScheduleList(supplierId: widget.driver?.agencyId);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          context
              .read<MyCompleteScheduleCubit>()
              .getMyCompleteScheduleList(supplierId: widget.driver?.agencyId);
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
    return BlocBuilder<MyCompleteScheduleCubit, MyCompleteScheduleState>(
      builder: (context, state) {
        if (state.status == MyCompleteScheduleStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context
              .read<MyCompleteScheduleCubit>()
              .getMyCompleteScheduleList(
                  supplierId: widget.driver?.agencyId, isOnRefresh: true),
          child: state.myCompleteSchedules.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.myCompleteSchedules.length +
                      (state.status == MyCompleteScheduleStatus.loadMore
                          ? 1
                          : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.myCompleteSchedules.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemSupplierSchedule(
                        ticket: state.myCompleteSchedules[index],
                        fullContent: false,
                        isShowTts: false,
                      )
                          .onTap(() => context.router.push(
                              MyCompleteDetailsPageRoute(
                                  ticketId: state
                                      .myCompleteSchedules[index].ticketId)))
                          .paddingBottom(AppDimens.paddingVerySmall);
                    }
                  }),
        );
      },
    );
  }
}
