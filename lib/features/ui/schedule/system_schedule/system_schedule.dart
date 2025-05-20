// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/features/ui/schedule/system_schedule/enroll_schedule/cubit/enroll_schedule_cubit.dart';
import 'package:pipcar/features/ui/schedule/system_schedule/enroll_schedule/enroll_schedule_screen.dart';
import 'package:pipcar/features/ui/schedule/system_schedule/new_schedule/cubit/new_schedule_cubit.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/di/di.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import 'new_schedule/new_schedule_screen.dart';

@RoutePage()
class SystemSchedulePageProvider extends StatelessWidget {
  final DriverDeleveringEntity? driver;
  final int? initialPage;
  const SystemSchedulePageProvider({
    Key? key,
    this.driver,
    this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<NewScheduleCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<EnrollScheduleCubit>(),
        ),
      ],
      child: SystemScheduleScreen(
        initialPage: initialPage,
        driver: driver,
      ),
    );
  }
}

class SystemScheduleScreen extends StatelessWidget {
  final DriverDeleveringEntity? driver;
  final int? initialPage;
  const SystemScheduleScreen({
    Key? key,
    this.driver,
    this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScaffoldWidget(
          appbar: AppBarWidget(
            title: "Danh sách lịch mới",
            titleStyle: ThemeText.appBar,
          ),
          body: DefaultTabController(
            length: 2,
            initialIndex: initialPage ?? 0,
            child: Column(children: [
              TabBar(
                isScrollable: false,
                padding: Platform.isIOS
                    ? EdgeInsets.only(top: 1.h)
                    : EdgeInsets.zero,
                labelColor: AppColor.primaryColor,
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
                tabs: const [
                  Tab(text: "Lịch mới"),
                  Tab(text: "Lịch đang bổ"),
                ],
                tabAlignment: TabAlignment.center,
              ),
              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NewSystemScheduleScreen(driver: driver),
                  EnrollScheduleScreen(driver: driver),
                ],
              ).expand(),
            ]),
          ).paddingTop(AppDimens.paddingMedium));
    });
  }
}
