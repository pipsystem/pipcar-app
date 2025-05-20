import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/core/presentation/bloc/auth_bloc/auth_cubit.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_constants.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/di/di.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../components/card_view.dart';
import 'cubit/menu_cubit.dart';
import 'menu_strings.dart';

@RoutePage()
class MenuPageProvider extends StatefulWidget {
  const MenuPageProvider({super.key});

  @override
  State<MenuPageProvider> createState() => _MenuPageProviderState();
}

class _MenuPageProviderState extends State<MenuPageProvider>
    with AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => getIt.get<MenuCubit>(),
      child: Scaffold(
        body: Builder(builder: (context) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<MenuCubit>().getAgencyInfor();
            },
            child: Column(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: BlocBuilder<MenuCubit, MenuState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          _buildAppBarMenu(context),
                          state.status == MenuStatus.loaded
                              ? _buildFeatureMenu(context,
                                  iconPath: Assets.images.icInfor.keyName,
                                  title: MenuStrings.inforAccount,
                                  subtitle: "${state.agencyInfor!.coin} coin",
                                  onpressed: () => context.router.push(
                                        ProfileRoute(
                                            agency: state.agencyInfor!),
                                      ))
                              : const SizedBox(),
                          Visibility(
                              visible: ["A2", "A3", "A4", "A5"]
                                  .contains(state.agencyInfor?.agencyType),
                              child: Column(
                                children: [
                                  _buildFeatureMenu(
                                    context,
                                    iconPath: Assets.images.icPerson.keyName,
                                    title: MenuStrings.inforDriver,
                                    subtitle: MenuStrings.inforDriverEx,
                                    onpressed: () => context.router
                                        .pushNamed(Routes.listDriver),
                                  ),
                                ],
                              )),
                          Visibility(
                              visible: ["A3"]
                                  .contains(state.agencyInfor?.agencyType),
                              child: Column(
                                children: [
                                  _buildFeatureMenu(
                                    context,
                                    iconPath: Assets.images.icConfig.keyName,
                                    title: MenuStrings.agencySettings,
                                    subtitle: MenuStrings.agencySettingsEx,
                                    onpressed: () => context.router
                                        .pushNamed(Routes.agencySettings),
                                  ),
                                ],
                              )),
                        ],
                      );
                    },
                  ),
                ).expand(),
                _buildButtonDeleteAccount(context),
                AppDimens.sizedBoxHeight10,
              ],
            ).paddingSymmetric(
              horizontal: AppDimens.paddingHorizontalApp,
              vertical: AppDimens.paddingVertical10,
            ),
          );
        }),
      ),
    );
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
          title: MenuStrings.features.toUpperCase(),
          style: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
          textAlign: TextAlign.center,
        ),
        ImageAppWidget(
          height: 25.h,
          path: Assets.images.icLogout.keyName,
          color: AppColor.primaryColor,
        ).onTap(() => getIt.get<AuthenticationCubit>().onLogoutRequested())
      ],
    ).paddingTop(AppDimens.appBarHeight).paddingBottom(AppDimens.paddingMedium).paddingRight(AppDimens.paddingMedium);
  }

  Widget _buildFeatureMenu(
    BuildContext context, {
    required String iconPath,
    required String title,
    required String subtitle,
    required VoidCallback onpressed,
  }) {
    return ButtonStyle1(
            prefixIcon: ImageAppWidget(
              height: AppDimens.buttonIconSize,
              path: iconPath,
              color: AppColor.primaryColor,
            ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
            title: title,
            subtitle: subtitle,
            onPressed: () => onpressed())
        ;
  }

  Widget _buildButtonDeleteAccount(BuildContext context) {
    return Visibility(
      visible: Platform.isIOS,
      child: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffFF0303)),
              borderRadius: BorderRadius.circular(AppDimens.borderButton),
            ),
            child: const StyleLabel(
              title: "Delete Your Account",
              style: TextStyle(
                color: Color(0xffFF0303),
                fontFamily: FontFamily.quicksand,
              ),
            )
                .paddingAll(AppDimens.paddingSmall),
          ).onTap(() => context.read<MenuCubit>().blockAccount());
        },
      ),
    ).paddingOnly(bottom: AppDimens.paddingVeryLarge);
  }
}
