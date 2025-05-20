// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';

import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_constants.dart';
import 'package:pipcar/features/ui/create_navigate_ticket/cubit/add_navigate_ticket_cubit.dart';
import 'package:pipcar/features/ui/schedule/my_schedule/my_accepted_schedule/cubit/my_accepted_schedule_cubit.dart';
import 'package:pipcar/features/ui/schedule/my_schedule/my_accepted_schedule/my_accepted_schedule_screen.dart';
import 'package:pipcar/features/ui/schedule/my_schedule/my_complete_schedule/cubit/my_complete_schedule_cubit.dart';
import 'package:pipcar/features/ui/schedule/my_schedule/my_complete_schedule/my_complete_schedule_screen.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/di/di.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import 'my_drop_off_schedule/cubit/my_drop_off_schedule_cubit.dart';
import 'my_drop_off_schedule/my_drop_off_schedule_screen.dart';

@RoutePage()
class MySchedulePageProvider extends StatelessWidget {
  final DriverDeleveringEntity? driver;
  final int? initialPage;
  const MySchedulePageProvider({
    Key? key,
    this.driver,
    this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<MyCompleteScheduleCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<MyAcceptedScheduleCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<MyDropOffScheduleCubit>(),
        ),
      ],
      child: MyScheduleScreen(
        initialPage: initialPage,
        driver: driver,
      ),
    );
  }
}

class MyScheduleScreen extends StatelessWidget {
  final DriverDeleveringEntity? driver;
  final int? initialPage;
  const MyScheduleScreen({
    Key? key,
    this.driver,
    this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScaffoldWidget(
          appbar: AppBarWidget(
            title: "Lịch của tôi",
            titleStyle: ThemeText.appBar,
            isReload: true,
            reloadAction: () {
              context.router.push(const DashBoardPageRoute());
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var addSchedule = await context.router.push(AddNavigatePageRoute(
                  supplierId: driver?.agencyId ?? LocalStorage.agencyId.val));
              if (addSchedule == AddNavigateStatus.createTicketSuccessful) {
                context
                    .read<MyAcceptedScheduleCubit>()
                    .getMyAcceptedScheduleList(
                        supplierId: driver?.agencyId, isOnRefresh: true);
              }
            },
            child: Icon(Icons.near_me_outlined, size: 35.w),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (driver != null)
                StyleLabel(
                  title:
                      "Lái xe: ${driver?.driverName} - ${driver?.driverPhone}",
                  style: ThemeText.caption.copyWith(fontSize: 14.sp),
                ).paddingOnly(bottom: 10.h, left: 10.w),
              if (driver != null)
                StyleLabel(
                        title: "${driver!.carName} - ${driver!.carPlate}",
                        style: ThemeText.body2)
                    .paddingOnly(bottom: 10.h, left: 10.w),
              DefaultTabController(
                length: 2,
                initialIndex: initialPage ?? 0,
                child: Column(children: [
                  TabBar(
                    isScrollable: false,
                    padding: Platform.isIOS
                        ? EdgeInsets.only(top: 1.h)
                        : EdgeInsets.zero,
                    labelColor: AppColor.primaryColor,
                    indicatorColor: AppColor.primaryColor,
                    unselectedLabelColor: AppColor.primaryColor,
                    labelStyle: ThemeText.body2,
                    // labelPadding: EdgeInsets.zero,
                    unselectedLabelStyle:
                        ThemeText.body2.copyWith(fontWeight: FontType.regular),
                    indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimens.borderSmall),
                      color: AppColor.lightBlue,
                    ),
                    indicatorWeight: 3,
                    dividerColor: AppColor.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(text: "Lịch chạy"),
                      Tab(text: "Đã trả khách"),
                    ],
                    tabAlignment: TabAlignment.center,
                  ),
                  TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      MyAcceptedScheduleScreen(driver: driver),
                      MyDropOffScheduleScreen(driver: driver),
                    ],
                  ).expand(),
                ]),
              ).paddingTop(AppDimens.paddingMedium).expand(),
            ],
          ));
    });
  }

  Widget _buildAppBarMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: AppbarConstants.buttonSize,
          height: AppbarConstants.buttonSize,
          child: ImageAppWidget(
            path: Assets.images.icBack.keyName,
            width: 20.w,
          ).paddingAll(AppDimens.paddingSmall).onTap(
            () => context.router.pop()
          )
        ),
        StyleLabel(
          title: "Lịch của tôi".toUpperCase(),
          style: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
          textAlign: TextAlign.center,
        ).paddingRight(AppDimens.paddingVeryLarge),
        Row()
      ],
    ).paddingTop(50.h).paddingRight(AppDimens.paddingMedium);
  }

}
