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
import 'cubit/enroll_schedule_cubit.dart';
import 'details_my_enroll/cubit/my_enroll_details_cubit.dart';

class EnrollScheduleScreen extends StatefulWidget {
  final DriverDeleveringEntity? driver;
  const EnrollScheduleScreen({
    Key? key,
    this.driver,
  }) : super(key: key);

  @override
  State<EnrollScheduleScreen> createState() => _EnrollScheduleScreenState();
}

class _EnrollScheduleScreenState extends State<EnrollScheduleScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    context
        .read<EnrollScheduleCubit>()
        .getEnrollScheduleList(supplierId: widget.driver?.agencyId);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          context
              .read<EnrollScheduleCubit>()
              .getEnrollScheduleList(supplierId: widget.driver?.agencyId);
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
    return BlocBuilder<EnrollScheduleCubit, EnrollScheduleState>(
      builder: (context, state) {
        if (state.status == EnrollScheduleStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context
              .read<EnrollScheduleCubit>()
              .getEnrollScheduleList(
                  supplierId: widget.driver?.agencyId, isOnRefresh: true),
          child: state.enrollSchedules.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.enrollSchedules.length +
                      (state.status == EnrollScheduleStatus.loadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.enrollSchedules.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemSupplierSchedule(
                        ticket: state.enrollSchedules[index],
                        fullContent: false,
                        isShowTts: false,
                      ).onTap(() async {
                        var details = await context.router.push(
                            MyEnrollDetailsPageRoute(
                                ticketId:
                                    state.enrollSchedules[index].ticketId));
                        if (details == MyEnrollDetailsStatus.cancel) {
                          context
                              .read<EnrollScheduleCubit>()
                              .getEnrollScheduleList(
                                  supplierId: widget.driver?.agencyId,
                                  isOnRefresh: true);
                        }
                      }).paddingBottom(AppDimens.paddingVerySmall);
                    }
                  }),
        );
      },
    );
  }
}
