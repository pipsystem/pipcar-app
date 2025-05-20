import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';

import '../../../../../domain/enterties/agency/agency_infor_entity.dart';
import '../../../components/card_view.dart';

@RoutePage()
class ProfileProvider extends StatelessWidget {
  final AgencyInforEntity agency;
  const ProfileProvider({super.key, required this.agency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: "Thông tin tài khoản",
          titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
        ),
        body: Column(
          children: [
            AppDimens.sizedBoxHeight10,
            ButtonStyle2(
              hasAction: false,
              prefixIcon: ImageAppWidget(
                height: AppDimens.buttonIconSize,
                path: Assets.images.icInfor.keyName,
                color: AppColor.primaryColor,
              ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
              title: agency.name,
              subtitle: agency.phone,
              onPressed: () {},
            ),
            ButtonStyle2(
                hasAction: true,
                prefixIcon: ImageAppWidget(
                  height: AppDimens.buttonIconSize,
                  path: Assets.images.icCoin.keyName,
                  color: AppColor.primaryColor,
                ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
                title: "Coin",
                subtitle: "${agency.coin}",
                onPressed: () {
                  context.router
                      .push(TransactionListRoute(currentCoin: agency.coin));
                }),
            ButtonStyle2(
                hasAction: false,
                prefixIcon: ImageAppWidget(
                  height: AppDimens.buttonIconSize,
                  path: Assets.images.icCoin.keyName,
                  color: AppColor.primaryColor,
                ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
                title: "Point",
                subtitle: "${agency.point}",
                onPressed: () {})
          ],
        ).paddingSymmetric(
            vertical: AppDimens.paddingMedium,
            horizontal: AppDimens.paddingHorizontalApp));
  }
}
