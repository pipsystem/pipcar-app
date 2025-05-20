// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

import 'package:pipcar/features/ui/schedule/pass_schedule/pass_list/details_pass/cubit/details_pass_cubit.dart';

import 'package:pipcar/features/ui/schedule/widgets/item_ticket_pass.dart';
import 'package:pipcar/features/ui/schedule/widgets/load_more_widget.dart';

import '../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import '../../widgets/empty_schedule.dart';
import 'cubit/pass_list_cubit.dart';

class PassListScreen extends StatefulWidget {
  const PassListScreen({super.key});

  @override
  State<PassListScreen> createState() => _PassListScreenState();
}

class _PassListScreenState extends State<PassListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
          context.read<PassListCubit>().getPassList();
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
    return BlocBuilder<PassListCubit, PassListState>(
      builder: (context, state) {
        if (state.status == PassListStatus.loadFirst) {
          return const ShimmerLoading();
        }
        return RefreshIndicator(
          onRefresh: () => context.read<PassListCubit>().getPassList(isOnRefresh: true),
          child: state.passList.isEmpty
              ? const EmptyListSchedule()
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: AppDimens.paddingSmall),
                  itemCount: state.passList.length + (state.status == PassListStatus.loadMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.passList.length) {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const LoadMoreCircular();
                    } else {
                      return ItemTicketPass(
                        ticket: state.passList[index],
                        fullContent: false,
                      ).paddingBottom(AppDimens.paddingVerySmall).onTap(() async {
                        var details =
                            await context.pushRoute(DetailsPassPageRoute(ticketId: state.passList[index].ticketId));

                        if (details == DetailsPassStatus.cancel || details == DetailsPassStatus.passAgainSuccess) {
                          context.read<PassListCubit>().getPassList(isOnRefresh: true);
                        } else if (details is String) {
                          context.router.pop();
                          context.pushRoute(PassSchedulePageRoute(initialPage: 1));
                          context.pushRoute(DetailsAcceptedPageRoute(ticketId: details));
                          context
                              .read<SnackbarBloc>()
                              .showSnackbar(translationKey: "Giao xe thành công", type: SnackBarType.success);
                        }
                      });
                    }
                  }),
        );
      },
    );
  }
}
