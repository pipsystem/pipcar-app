// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/features/ui/schedule/my_schedule/my_accepted_schedule/cubit/my_accepted_schedule_cubit.dart';

import '../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../widgets/empty_schedule.dart';
import '../../widgets/item_supplier_schedule.dart';
import '../../widgets/load_more_widget.dart';

class MyAcceptedScheduleScreen extends StatefulWidget {
  final DriverDeleveringEntity? driver;
  const MyAcceptedScheduleScreen({
    Key? key,
    this.driver,
  }) : super(key: key);

  @override
  State<MyAcceptedScheduleScreen> createState() =>
      _MyAcceptedScheduleScreenState();
}

class _MyAcceptedScheduleScreenState extends State<MyAcceptedScheduleScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    context
        .read<MyAcceptedScheduleCubit>()
        .getMyAcceptedScheduleList(supplierId: widget.driver?.agencyId);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          context
              .read<MyAcceptedScheduleCubit>()
              .getMyAcceptedScheduleList(supplierId: widget.driver?.agencyId);
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
    return BlocBuilder<MyAcceptedScheduleCubit, MyAcceptedScheduleState>(
      builder: (context, state) {
        if (state.status == MyAcceptedScheduleStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context
              .read<MyAcceptedScheduleCubit>()
              .getMyAcceptedScheduleList(
                  supplierId: widget.driver?.agencyId, isOnRefresh: true),
          child: state.myAcceptedSchedules.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.myAcceptedSchedules.length +
                      (state.status == MyAcceptedScheduleStatus.loadMore
                          ? 1
                          : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.myAcceptedSchedules.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemSupplierSchedule(
                        ticket: state.myAcceptedSchedules[index],
                        fullContent: false,
                        isShowTts: false,
                      )
                          .onTap(() => context.router.push(
                              MyAcceptedDetailsPageRoute(
                                  driver: widget.driver,
                                  ticketId: state
                                      .myAcceptedSchedules[index].ticketId)))
                          .paddingBottom(AppDimens.paddingVerySmall);
                    }
                  }),
        );
      },
    );
  }
}
