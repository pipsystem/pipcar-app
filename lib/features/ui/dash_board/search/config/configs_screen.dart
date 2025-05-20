import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/utils/extension_utils.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pipcar/core/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pipcar/core/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:pipcar/core/presentation/widgets/text_field_widget/text_field_widget.dart';
import 'package:pipcar/core/presentation/widgets/text_widget/style_lable.dart';
import 'package:pipcar/features/ui/dash_board/search/config/config_address_search/config_district_search_screen.dart';
import 'package:pipcar/features/ui/dash_board/search/config/config_address_search/config_provice__search_screen.dart';
import 'package:pipcar/features/ui/dash_board/search/cubit/search_cubit.dart';

import '../../../../../common/themes/themes.dart';

class ConfigSearchScreen extends StatefulWidget {
  const ConfigSearchScreen({super.key});

  @override
  State<ConfigSearchScreen> createState() => _ConfigSearchScreenState();
}

class _ConfigSearchScreenState extends State<ConfigSearchScreen> {
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<SearchCubit>().resetConfigs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        appbar: AppBarWidget(
          title: "Cấu hình tìm kiếm",
          titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDimens.sizedBoxHeight10,
                StyleLabel(
                  title: "Khu vực đón khách",
                  style: ThemeText.body2,
                ).paddingTop(AppDimens.paddingLarge).paddingBottom(AppDimens.paddingSmall),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.borderCard, width: 0.5),
                      borderRadius: BorderRadius.circular(AppDimens.borderSmall)),
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          _buildHorizontalText(
                                  icon: Icons.location_city,
                                  title: "${state.selectedProvinceConfig?.name} (Tỉnh thành đón)")
                              .onTap(() => 
                                BlocProvider.value(
                                  value: context.read<SearchCubit>(),
                                  child: const ConfigProvinceSearchScreen(),
                                ).launch(context)
                                  ),
                          const Divider(color: AppColor.dividerColor, height: 0, endIndent: 20, indent: 20),
                          _buildHorizontalText(
                                  icon: Icons.location_city,
                                  title: "${state.selectedDistrictConfig?.name} (Quận huyện đón)")
                              .onTap(() => 
                              BlocProvider.value(
                                value: context.read<SearchCubit>(),
                                child: const ConfigDistrictSearchScreen(),
                              ).launch(context)
                                  )
                        ],
                      );
                    },
                  ),
                ).paddingBottom(AppDimens.paddingLarge),
                Form(
                  key: formkey,
                  child: TextFieldPickUpTime2(
                      controller: context.read<SearchCubit>().pickUpTimeController,
                      onConfirm: (date) {
                        context.read<SearchCubit>().selectPickUpTime(date);
                      }),
                )
              ],
            ),
            TextButtonWidget(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  context.pop();
                  context.read<SearchCubit>().getListAgencySearch();
                }
              },
              title: "Xác nhận",
              titleColor: AppColor.white,
              buttonColor: AppColor.primaryColor,
            ).paddingSymmetric(vertical: AppDimens.paddingMedium)
          ],
        ));
  }

  Widget _buildHorizontalText({required IconData icon, required String title, bool enalble = true}) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: AppDimens.iconMediumSize).paddingSymmetric(horizontal: 6.w),
        StyleLabel(title: title, style: ThemeText.note.copyWith(fontWeight: FontWeight.bold)).expand(),
        Visibility(
          visible: enalble,
          child: Icon(
            Icons.arrow_drop_down,
            color: AppColor.primaryColor,
            size: AppDimens.iconMediumSize,
          ),
        ).paddingSymmetric(horizontal: 6.w)
      ],
    ).paddingSymmetric(vertical: 16.h);
  }
}
