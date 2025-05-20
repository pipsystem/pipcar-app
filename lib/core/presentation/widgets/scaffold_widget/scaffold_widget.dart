import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';

import '../widgets.dart';

class ScaffoldWidget extends StatelessWidget {
  final AppBarWidget? appbar;
  final Widget body;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? backgroundImage;
  final FloatingActionButton? floatingActionButton;

  const ScaffoldWidget({
    Key? key,
    required this.body,
    this.appbar,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.backgroundImage,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          backgroundImage ?? const SizedBox(),
          body
              .paddingTop(
                  appbar != null ? AppBar().preferredSize.height + 30.h : 0)
              .paddingSymmetric(horizontal: AppDimens.paddingHorizontalApp),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
