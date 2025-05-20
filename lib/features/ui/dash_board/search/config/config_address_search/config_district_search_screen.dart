import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/themes/theme_text.dart';
import 'package:pipcar/core/presentation/widgets/address_search_widget/address_search_widget.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pipcar/core/presentation/widgets/scaffold_widget/scaffold_widget.dart';

// ignore: must_be_immutable
class ConfigDistrictSearchScreen extends StatelessWidget {
  const ConfigDistrictSearchScreen({super.key});
  
  @override
  Widget build (BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: "Quận huyện",
        titleStyle: ThemeText.appBar,
      ),
      body: Column(
        children: [
          AddressSearchWidget(district: true)
        ],
      ).paddingSymmetric(horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}