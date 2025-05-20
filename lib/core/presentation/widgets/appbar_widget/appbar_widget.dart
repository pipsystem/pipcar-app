// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/image_app_widget/image_app.dart';

import '../../../../common/themes/theme_color.dart';
import '../../../../common/themes/theme_text.dart';
import 'appbar_constants.dart';

class AppBarButton extends StatelessWidget {
  final Widget? child;
  final String? iconSource;
  final Color? iconColor;
  final Function()? onTap;
  final double? width;
  final double? height;

  const AppBarButton({
    Key? key,
    this.child,
    this.iconSource,
    this.onTap,
    this.width,
    this.height,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppbarConstants.buttonSize,
      width: AppbarConstants.buttonSize,
      child: InkWell(
        onTap: onTap,
        child: child ??
            Center(
              child: SvgPicture.asset(
                iconSource!,
                color: iconColor ?? Colors.white,
                width: width ?? AppbarConstants.buttonIconSize,
                height: height ?? AppbarConstants.buttonIconSize,
              ),
            ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? action;
  final bool? isReload;
  final Function? reloadAction;
  final String? title;
  final Widget? centerWidget;
  final TextStyle? titleStyle;
  final Color? color;
  final bool? iconBackBlack;

  const AppBarWidget(
      {Key? key,
      this.leading,
      this.title,
      this.action,
      this.isReload,
      this.reloadAction,
      this.centerWidget,
      this.titleStyle,
      this.color,
      this.iconBackBlack})
      : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    // final top = MediaQuery.of(context).padding.top;
    return AppBar(
      backgroundColor: color ?? Colors.transparent,
      forceMaterialTransparency: true,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          Expanded(
            child: centerWidget ??
                Text(
                  title?.toUpperCase() ?? '',
                  style: titleStyle ??
                      ThemeText.appBar.copyWith(
                        color: AppColor.white,
                      ),
                  textAlign: TextAlign.center,
                ),
          ),
        ],
      ),
      leading: leading ??
          SizedBox(
            width: AppbarConstants.buttonSize,
            height: AppbarConstants.buttonSize,
            child: ImageAppWidget(
              path: iconBackBlack == true ? Assets.images.icBackDark.keyName : Assets.images.icBack.keyName,
              width: 20,
            ).paddingAll(AppDimens.paddingSmall).onTap(
                  isReload == true
                  ? reloadAction
                  : () => context.router.pop()
                ),
          ),
      actions: [
        action != null
            ? action!
            : SizedBox(
                width: AppbarConstants.buttonSize,
                height: AppbarConstants.buttonSize,
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
