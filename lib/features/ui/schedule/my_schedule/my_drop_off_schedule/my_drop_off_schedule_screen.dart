// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

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
import 'cubit/my_drop_off_schedule_cubit.dart';

class MyDropOffScheduleScreen extends StatefulWidget {
  final DriverDeleveringEntity? driver;
  const MyDropOffScheduleScreen({
    Key? key,
    this.driver,
  }) : super(key: key);

  @override
  State<MyDropOffScheduleScreen> createState() =>
      _MyDropOffScheduleScreenState();
}

class _MyDropOffScheduleScreenState extends State<MyDropOffScheduleScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    context
        .read<MyDropOffScheduleCubit>()
        .getMyDropOffScheduleList(supplierId: widget.driver?.agencyId);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          context
              .read<MyDropOffScheduleCubit>()
              .getMyDropOffScheduleList(supplierId: widget.driver?.agencyId);
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
    return BlocBuilder<MyDropOffScheduleCubit, MyDropOffScheduleState>(
      builder: (context, state) {
        if (state.status == MyDropOffScheduleStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context
              .read<MyDropOffScheduleCubit>()
              .getMyDropOffScheduleList(
                  supplierId: widget.driver?.agencyId, isOnRefresh: true),
          child: state.myDropOffSchedules.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.myDropOffSchedules.length +
                      (state.status == MyDropOffScheduleStatus.loadMore
                          ? 1
                          : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.myDropOffSchedules.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemSupplierSchedule(
                        ticket: state.myDropOffSchedules[index],
                        fullContent: false,
                        isShowTts: false,
                      )
                          .onTap(() => context.router.push(
                              MyDropOffDetailsPageRoute(
                                  ticketId: state
                                      .myDropOffSchedules[index].ticketId)))
                          .paddingBottom(AppDimens.paddingVerySmall);
                    }
                  }),
        );
      },
    );
  }
}
