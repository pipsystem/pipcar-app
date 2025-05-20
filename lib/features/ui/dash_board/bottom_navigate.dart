import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/bloc/internet_bloc/internet_cubit.dart';
import 'package:pipcar/core/presentation/widgets/internet_disconnect_widget.dart';
import 'package:rxdart/rxdart.dart';

import '../../../common/assets/assets.gen.dart';
import '../../../common/themes/themes.dart';
import 'button_tab.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final TabController tabController;

  const BottomNavigationBarWidget({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  // ignore: close_sinks
  final indexSubject = PublishSubject<int>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<InternetCubit, InternetState>(
          builder: (context, state) {
            if (state.status == InternetStatus.disconnected) {
              return const InternetDisconnect();
            } else {
              return const SizedBox();
            }
          },
        ),
        Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom, left: 4, right: 4),
          height: 48.h + MediaQuery.of(context).padding.bottom,
          decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                    color: AppColor.black.withOpacity(0.25),
                    blurRadius: 5,
                    offset: const Offset(0, 1))
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimens.roundedRadius),
                  topRight: Radius.circular(AppDimens.borderSmall))),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                _bottomNavBar(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomNavBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: StreamBuilder<int>(
          stream: indexSubject,
          builder: (context, snapshot) {
            final selectedIndex = snapshot.data ?? 0;
            widget.tabController.animateTo(selectedIndex);
            return Row(
              children: [
                ButtonTabWidget(
                  iconName: Assets.images.icHome2.keyName,
                  size: 32.w,
                  index: 0,
                  indexNotifier: indexSubject,
                  tabController: widget.tabController,
                  selectedIndex: selectedIndex,
                ),
                ButtonTabWidget(
                  iconName: Assets.images.addCircle.keyName,
                  size: 20.w,
                  index: 1,
                  tabController: widget.tabController,
                  indexNotifier: indexSubject,
                  selectedIndex: selectedIndex,
                ),
                ButtonTabWidget(
                  iconName: Assets.images.icMenu2.keyName,
                  size: 32.w,
                  index: 2,
                  tabController: widget.tabController,
                  indexNotifier: indexSubject,
                  selectedIndex: selectedIndex,
                ),
              ],
            );
          }),
    );
  }
}
