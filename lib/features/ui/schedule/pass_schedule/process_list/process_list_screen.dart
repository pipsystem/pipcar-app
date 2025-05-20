import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/process_list/details_process/cubit/details_process_cubit.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/process_list/details_process/details_process_screen.dart';
import 'package:pipcar/features/ui/schedule/widgets/empty_schedule.dart';

import 'package:pipcar/features/ui/schedule/widgets/load_more_widget.dart';

import '../../widgets/item_ticket_process.dart';
import 'cubit/process_list_cubit.dart';

class ProcessListScreen extends StatefulWidget {
  const ProcessListScreen({super.key});

  @override
  State<ProcessListScreen> createState() => _ProcessListScreenState();
}

class _ProcessListScreenState extends State<ProcessListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
          context.read<ProcessListCubit>().getProcessList();
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
    return BlocBuilder<ProcessListCubit, ProcessListState>(
      builder: (context, state) {
        if (state.status == ProcessListStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context.read<ProcessListCubit>().getProcessList(isOnRefresh: true),
          child: state.processList.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.processList.length + (state.status == ProcessListStatus.loadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.processList.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemTicketProcess(
                        ticket: state.processList[index],
                        fullContent: false,
                      ).paddingBottom(AppDimens.paddingVerySmall)
                          // .onTap(() {
                          //   BlocProvider.value(
                          //       value: context.read<ProcessListCubit>(),
                          //       child: DetailsProcessPageProvider(ticketId: state.processList[index].ticketId,),
                          //     ).launch(context);
                          // });
                      .onTap(()async {
                        var details = await context
                            .pushRoute(DetailsProcessPageRoute(ticketId: state.processList[index].ticketId));
                        if (details == DetailsProcessStatus.completeSuccess) {
                          context.read<ProcessListCubit>().getProcessList(isOnRefresh: true);
                        }
                      });
                    }
                  }),
        );
      },
    );
  }
}
