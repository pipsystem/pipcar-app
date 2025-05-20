// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/accepted_list/accepted_list_screen.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/add_schedule/cubit/add_schedule_cubit.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/pass_list/cubit/pass_list_cubit.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/pass_list/pass_list_screen.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/process_list/cubit/process_list_cubit.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/process_list/process_list_screen.dart';

import '../../../../common/di/di.dart';
import '../../../../common/themes/themes.dart';
import 'accepted_list/cubit/accepted_list_cubit.dart';

@RoutePage()
class PassSchedulePageProvider extends StatelessWidget {
  final int? initialPage;
  const PassSchedulePageProvider({super.key, this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<PassListCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AcceptedListCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<ProcessListCubit>(),
        ),
        
      ],
      child: PassScheduleScreen(
        initialPage: initialPage,
      ),
    );
  }
}

class PassScheduleScreen extends StatelessWidget {
  final int? initialPage;
  const PassScheduleScreen({
    Key? key,
    this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScaffoldWidget(
          appbar: AppBarWidget(
            title: "Danh sách lịch pass",
            titleStyle: ThemeText.appBar,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var addSchedule =
                  await context.router.pushNamed(Routes.addSchedule);
              if (addSchedule == AddScheduleStatus.createTicketSuccessful) {
                context.read<PassListCubit>().getPassList(isOnRefresh: true);
              }
            },
            child: Icon(Icons.add_rounded, size: AppDimens.iconMediumSize),
          ),
          body: DefaultTabController(
            length: 3,
            initialIndex: initialPage ?? 0,
            child: Column(children: [
              TabBar(
                isScrollable: false,
                padding: Platform.isIOS
                    ? EdgeInsets.only(top: 15.h)
                    : EdgeInsets.zero,
                labelColor: AppColor.primaryColor,
                indicatorColor: AppColor.primaryColor,
                unselectedLabelColor: AppColor.primaryColor,
                labelStyle: ThemeText.body2,
                unselectedLabelStyle:
                    ThemeText.body2.copyWith(fontWeight: FontType.regular),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.borderSmall),
                  color: AppColor.lightBlue,
                ),
                dividerColor: AppColor.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                tabAlignment: TabAlignment.center,
                labelPadding: EdgeInsets.only(right: AppDimens.paddingMedium, left: AppDimens.paddingMedium),
                tabs: const [
                  Tab(text: "Đang pass"),
                  Tab(text: "Đã giao"),
                  Tab(text: "Đón trả khách"),
                ],
              ),
              const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PassListScreen(),
                  AcceptedListScreen(),
                  ProcessListScreen(),
                ],
              ).expand(),
            ]),
          ));
    });
  }
}
