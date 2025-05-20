// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:pipcar/common/themes/themes.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/features/ui/schedule/system_schedule/new_schedule/cubit/new_schedule_cubit.dart';

import '../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../widgets/empty_schedule.dart';
import '../../widgets/item_supplier_schedule.dart';
import '../../widgets/load_more_widget.dart';

class NewSystemScheduleScreen extends StatefulWidget {
  final DriverDeleveringEntity? driver;
  const NewSystemScheduleScreen({
    Key? key,
    this.driver,
  }) : super(key: key);

  @override
  State<NewSystemScheduleScreen> createState() =>
      _NewSystemScheduleScreenState();
}

class _NewSystemScheduleScreenState extends State<NewSystemScheduleScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    context
        .read<NewScheduleCubit>()
        .getNewScheduleList(supplierId: widget.driver?.agencyId);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          context
              .read<NewScheduleCubit>()
              .getNewScheduleList(supplierId: widget.driver?.agencyId);
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
    return BlocBuilder<NewScheduleCubit, NewScheduleState>(
      builder: (context, state) {
        if (state.status == NewScheduleStatus.loadFirst) {
          return const ShimmerLoading();
        } else if (state.status == NewScheduleStatus.applySuccess) {
          context.pop();
          context.router.push(SystemSchedulePageRoute(initialPage: 1));
          context.read<SnackbarBloc>().showSnackbar(
              translationKey: "Bổ lịch thành công", type: SnackBarType.success);
        }
        return RefreshIndicator(
          onRefresh: () => context.read<NewScheduleCubit>().getNewScheduleList(
              supplierId: widget.driver?.agencyId, isOnRefresh: true),
          child: state.newSchedules.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.newSchedules.length +
                      (state.status == NewScheduleStatus.loadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.newSchedules.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return SwipeTo(
                        onLeftSwipe: () {
                          context
                              .read<NewScheduleCubit>()
                              .applyTicket(state.newSchedules[index].ticketId);
                        },
                        iconColor: Colors.white,
                        leftSwipeWidget: Container(
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Bổ lịch",
                              style: ThemeText.caption.copyWith(
                                  fontWeight: FontType.semiBold,
                                  color: AppColor.white),
                            ),
                          ).paddingAll(AppDimens.paddingSmall),
                        ),
                        child: ItemSupplierSchedule(
                          ticket: state.newSchedules[index],
                          showStatusName: false,
                          fullContent: false,
                        ).onTap(() async {
                          var details = await 
                          context.router.push(
                              NewDetailsPageRoute(
                                  ticketId:
                                      state.newSchedules[index].ticketId));
                          if (details is String) {
                            context.pop();
                            context.router.push(SystemSchedulePageRoute(
                                driver: widget.driver, initialPage: 1));
                            context.router.push(
                                MyEnrollDetailsPageRoute(ticketId: details));
                            context.read<SnackbarBloc>().showSnackbar(
                                translationKey: "Bổ lịch thành công",
                                type: SnackBarType.success);
                          }
                        }).paddingBottom(AppDimens.paddingVerySmall),
                      );
                    }
                  }),
        );
      },
    );
  }
}
