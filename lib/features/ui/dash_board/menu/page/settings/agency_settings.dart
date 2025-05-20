import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';

import '../../../components/card_view.dart';

@RoutePage()
class AgencySettingsProvider extends StatelessWidget {
  const AgencySettingsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: "Cấu hình tài khoản",
          titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
        ),
        body: Column(
          children: [
            ToggleButtonStyle(
              hasAction: false,
              prefixIcon: ImageAppWidget(
                height: AppDimens.buttonIconSize,
                path: Assets.images.icCoin.keyName,
                color: AppColor.primaryColor,
              ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
              title: "Chức năng bổ lịch",
              subtitle: "Phí sử dụng 5 coin/ngày (01/01/2025)",
              toggleValue: false,
              onPressed: () {},
            ).paddingSymmetric(
                vertical: AppDimens.paddingVerticalApp,
                horizontal: AppDimens.paddingHorizontalApp),
          ],
        ));
  }
}
