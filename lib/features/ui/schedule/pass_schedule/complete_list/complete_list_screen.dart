import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/schedule/widgets/empty_schedule.dart';

import 'package:pipcar/features/ui/schedule/widgets/load_more_widget.dart';

import '../../widgets/item_ticket_complete.dart';
import 'cubit/complete_list_cubit.dart';

class CompleteListScreen extends StatefulWidget {
  const CompleteListScreen({super.key});

  @override
  State<CompleteListScreen> createState() => _CompleteListScreenState();
}

class _CompleteListScreenState extends State<CompleteListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
          context.read<CompleteListCubit>().getCompleteList();
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
    return BlocBuilder<CompleteListCubit, CompleteListState>(
      builder: (context, state) {
        if (state.status == CompleteListStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context.read<CompleteListCubit>().getCompleteList(isOnRefresh: true),
          child: state.completeList.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.completeList.length + (state.status == CompleteListStatus.loadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.completeList.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemTicketComplete(
                        ticket: state.completeList[index],
                        fullContent: false,
                      )
                          .onTap(() => context.router
                              .push(DetailsCompletePageRoute(ticketId: state.completeList[index].ticketId)))
                          .paddingBottom(AppDimens.paddingVerySmall);
                    }
                  }),
        );
      },
    );
  }
}
