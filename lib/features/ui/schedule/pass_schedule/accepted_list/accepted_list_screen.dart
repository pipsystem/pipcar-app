// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

import 'package:pipcar/features/ui/schedule/widgets/load_more_widget.dart';

import '../../../../../core/presentation/routers/app_router.dart';
import '../../widgets/empty_schedule.dart';
import '../../widgets/item_ticket_accepted.dart';
import 'cubit/accepted_list_cubit.dart';
import 'details_accepted/cubit/details_accepted_cubit.dart';

class AcceptedListScreen extends StatefulWidget {
  const AcceptedListScreen({super.key});

  @override
  State<AcceptedListScreen> createState() => _AcceptedListScreenState();
}

class _AcceptedListScreenState extends State<AcceptedListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
          context.read<AcceptedListCubit>().getAcceptedList();
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
    return BlocBuilder<AcceptedListCubit, AcceptedListState>(
      builder: (context, state) {
        if (state.status == AcceptedListStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context.read<AcceptedListCubit>().getAcceptedList(isOnRefresh: true),
          child: (state.acceptedList.isNotEmpty && state.acceptedList.any((element) => element.status == 1))
              ? ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.acceptedList.length + (state.status == AcceptedListStatus.loadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.acceptedList.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return state.acceptedList[index].status == 1 ? ItemTicketAccepted(ticket: state.acceptedList[index], fullContent: false)
                          .paddingBottom(AppDimens.paddingVerySmall)
                          .onTap(() async {
                        var details = await context
                            .pushRoute(DetailsAcceptedPageRoute(ticketId: state.acceptedList[index].ticketId));
                        if (details == DetailsAcceptedStatus.cancel) {
                          context.read<AcceptedListCubit>().getAcceptedList(isOnRefresh: true);
                        } else if (details is String) {
                          context.router.pop();
                          context.pushRoute(PassSchedulePageRoute(initialPage: 2));
                          context.pushRoute(DetailsCompletePageRoute(ticketId: details));
                        }
                      }) : SizedBox();
                    }
                  })
              : const EmptyListSchedule()
        );
      },
    );
  }
}
