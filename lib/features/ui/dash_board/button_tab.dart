import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/image_app_widget/image_app.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/themes/themes.dart';
import '../schedule/pass_schedule/add_schedule/cubit/add_schedule_cubit.dart';

class ButtonTabWidget extends StatelessWidget {
  final TabController? tabController;
  final PublishSubject<int>? indexNotifier;
  final String iconName;
  final int index;
  final int selectedIndex;
  final double? size;

  const ButtonTabWidget(
      {Key? key,
      required this.iconName,
      this.indexNotifier,
      required this.index,
      required this.selectedIndex,
      required this.tabController,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () async {
          if (index == 1) {
            var addResult = await context.router.pushNamed(Routes.addSchedule);
            if (addResult == AddScheduleStatus.createTicketSuccessful) {
              context.router.push(PassSchedulePageRoute());
            }
          }else if(index == 2) {
            context.router.push(const MenuPageRoute());
          } else {
            tabController?.animateTo(index);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.h,
              height: 40.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white,
              ),
              child: Center(
                child: ImageAppWidget(
                  path: iconName,
                  width: size == 32.w ? 26.w : size,
                  color: AppColor.primaryColor,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
