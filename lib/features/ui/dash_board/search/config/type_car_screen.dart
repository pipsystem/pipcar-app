import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/domain/enterties/car_type_entity.dart';
import 'package:pipcar/features/ui/dash_board/search/cubit/search_cubit.dart';

import '../../../../../common/themes/themes.dart';

@RoutePage()
class TypeCarPageProvider extends StatelessWidget {
  const TypeCarPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 30,
                children: [
                  ItemTypeCar(
                    carType: AppConstant.listCarType[0],
                    description: "Tối đa 4 khách",
                  ),
                  ItemTypeCar(carType: AppConstant.listCarType[1], description: "Tối đa 6 khách"),
                  ItemTypeCar(carType: AppConstant.listCarType[2], description: "Tối đa 15 khách"),
                  ItemTypeCar(carType: AppConstant.listCarType[3], description: "Tối đa 30 khách"),
                  ItemTypeCar(carType: AppConstant.listCarType[4], description: "Tối đa 40 khách"),
                  ItemTypeCar(carType: AppConstant.listCarType[5], description: "Tối đa 50 khách"),
                  ItemTypeCar(carType: AppConstant.listCarType[6], description: "Tối đa 8 khách"),
                ],
              ).paddingAll(AppDimens.paddingVeryLarge).paddingTop(AppDimens.paddingVeryLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemTypeCar extends StatelessWidget {
  final CarTypeEntity carType;
  final String description;
  const ItemTypeCar({super.key, required this.carType, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.w,
      width: 130.w,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppDimens.borderSmall),
          boxShadow: [BoxShadow(color: AppColor.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 1))]),
      child: Column(
        children: [
          ImageAppWidget(
            path: carType.image,
            height: carType.id == 1 ? 22.h : 30.h,
            fit: BoxFit.fitHeight,
          ).paddingOnly(top: carType.id == 1 ? 24.h : 20.h, bottom: carType.id == 1 ? 20.h : 16.h),
          StyleLabel(
            title: carType.name,
            style: ThemeText.body2.copyWith(fontWeight: FontWeight.w400),
          ),
          StyleLabel(
            title: description,
            style: ThemeText.note.copyWith(color: AppColor.borderCard),
          )
        ],
      ),
    ).onTap(() {
      context.pop();
      context.read<SearchCubit>().selectCarType(carType);
    }).paddingBottom(AppDimens.paddingLarge);
  }
}
