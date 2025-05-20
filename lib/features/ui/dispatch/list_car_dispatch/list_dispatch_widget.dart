// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/driver_item_list_entity.dart';
import 'package:pipcar/features/domain/enterties/car_entity.dart';

import 'package:pipcar/features/domain/enterties/dispatch/analyst_angency_entity.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/cubit/list_dispatch_cubit.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/detail_driver/details_driver_provider.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/detail_driver/details_driver_screen.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/list_car_dispatch_screen.dart';

import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../common/assets/assets.gen.dart';
import '../../../../core/presentation/routers/app_router.dart';
import '../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../dash_board/components/card_view.dart';
import '../widget/infor_currency.dart';

//Item have both driver and car
class DispatchCarItem extends StatelessWidget {
  final DriverItemListEntity driver;
  const DispatchCarItem({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return CardFormView(
      colorBoder: AppColor.primaryColor,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 12,
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height / 12,
                child: FormChildButtonStyle2(
                  prefixIcon: ImageAppWidget(
                    height: AppDimens.buttonIconSize,
                    path: Assets.images.icPerson.keyName,
                    color: AppColor.primaryColor,
                  ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
                  title: driver.name,
                  subtitle: '${driver.phone} / ${driver.agencyCode}',
                  subIcon: driver.agencyCode == null ? const SizedBox() : const Icon(Icons.file_copy_outlined, color: AppColor.primaryColor).paddingLeft(AppDimens.paddingMedium),
                  checkBox: false,
                  hasAction: false,
                  sufixIcon: driver.agencyId == '' ?
                    const Icon(Icons.close_rounded)
                    : ImageAppWidget(
                      path: Assets.images.icArrowRight2.keyName,
                      height: AppDimens.iconMediumSize,
                    ),
                  onTapSufixIcon: driver.carInfor != null 
                      ? () async {
                        await Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DetailsDriverProvider(agencyId: driver.agencyId, carId: driver.carInfor!.carId, driverId: driver.driverId);
                          }
                        ));
                      } 
                      : () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ListCarDispatchProvider(driverId: driver.driverId);
                            },
                          )).then((value) {
                            context.read<ListDispatchCubit>().getListCar();
                          });
                      },
                  onTapSubIcon: driver.agencyCode == null ? () {} : () {
                      FlutterClipboard.copy('${driver.phone} / ${driver.agencyCode}');
                      AppUtils.showToast("Đã copy số điện thoại / mã");
                  },
                  )),
          ),
          driver.carInfor != null 
          ? Divider(
            color: AppColor.dividerColor,
            thickness: 1,
          )
          : SizedBox(),
          driver.carInfor != null 
          ? SizedBox(
              height: MediaQuery.sizeOf(context).height / 12,
              child: FormChildButtonStyle2(
                prefixIcon: ImageAppWidget(
                  height: AppDimens.buttonIconSize,
                  path: Assets.images.icCars.keyName,
                  color: AppColor.primaryColor,
                ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
                title: driver.carInfor!.name,
                subtitle: driver.carInfor!.plates,
                checkBox: true,
                check: true,
                hasAction: false,
                onTapCheckBox: () {
                  getIt.get<DialogBloc>().showOptionDialog(
                    title: "Thông báo",
                    message: "Bạn có chắc muốn huỷ giao xe\n${driver.carInfor!.name}\n${driver.carInfor!.plates}\n${driver.name}\n${driver.phone}",
                    acceptAction: () async {
                      await context.read<ListDispatchCubit>().putUnDeliverCar(driver.driverId);
                      await context.router.pop();
                      await context.router.pushNamed(Routes.listDispatch);
                    }
                  );
                },
                // sufixIcon: Icon(
                //   Icons.delete_outline,
                //   color: AppColor.hintColor,
                // ).onTap(() => context.read<ListDriverCubit>().undeliverCar(driver.driverId)),
              ))
          : SizedBox(),
        ],
      ),
    ).paddingBottom(AppDimens.paddingMedium);
  }
}

// Item have only driver
class DriverItem extends StatelessWidget {
  final DriverItemListEntity driver;
  const DriverItem({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ButtonStyle2(
            onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ListCarDispatchProvider(driverId: driver.driverId);
                  },
                )).then((value) {
                  context.read<ListDispatchCubit>().getListCar();
                });
              },
            prefixIcon: ImageAppWidget(
              height: AppDimens.buttonIconSize,
              path: Assets.images.icPerson.keyName,
              color: AppColor.primaryColor,
            ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
            sufixIcon: driver.agencyId == '' ?
                const Icon(Icons.close_rounded)
                  : ImageAppWidget(
                    path: Assets.images.icArrowRight2.keyName,
                    height: AppDimens.iconMediumSize,
                  ),
            borderFormColor: AppColor.primaryColor,
            title: driver.name,
            subtitle: driver.phone,
          ),
        ],
      ).paddingBottom(AppDimens.paddingMedium),
    );
  }
}

// Item car to select
class CarItem extends StatelessWidget {
  final CarEntity car;
  final bool select;
  final VoidCallback onTap;
  CarItem({super.key, required this.car, required this.select, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ButtonStyle2(
            onPressed: 
              onTap,
            prefixIcon: ImageAppWidget(
              height: AppDimens.buttonIconSize,
              path: Assets.images.icCars.keyName,
              color: AppColor.primaryColor,
            ).paddingSymmetric(horizontal: AppDimens.paddingVerySmall),
            sufixIcon: select ? ImageAppWidget(
                                  path: Assets.images.icCheck.keyName,
                                  height: AppDimens.buttonIconSize24,
                                ).paddingRight(AppDimens.paddingMedium) 
                              : const Icon(Icons.no_cell, color: white),
            borderFormColor: AppColor.primaryColor,
            title: car.carName,
            subtitle: car.carPlates,
          ),
        ],
      ).paddingBottom(AppDimens.paddingSmall),
    );
  }
  
}

class AnalysticAngencyBlock extends StatelessWidget {
  final AnalystAgencyEntity? analystInfor;
  const AnalysticAngencyBlock({
    Key? key,
    this.analystInfor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return analystInfor == null
        ? CardFormView(
            child: SizedBox(
            height: 50.h,
            width: double.infinity,
            child: const Center(
                child: CircularProgressIndicator(
              color: AppColor.lightGrey,
              strokeWidth: 1.5,
            )),
          ))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardFormView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InforCurrency(
                              title: 'Thu nhập',
                              amount: '${analystInfor!.revenue} coin',
                              iconPath: Assets.images.icCoin.keyName)
                          .expand(),
                      Container(
                        color: AppColor.primaryColor,
                        width: 2,
                        height: 55.h,
                      ),
                      InkWell(
                        onTap: () =>
                            context.router.pushNamed(Routes.statiticExpense),
                        child: InforCurrency(
                            title: 'Chi phí',
                            amount: '${analystInfor!.cost} coin',
                            iconPath: Assets.images.icCoinGrey.keyName),
                      ).expand(),
                    ],
                  ),
                  const MySeparator(color: AppColor.lightGrey),
                  InforCurrency(
                      title: 'Lợi nhuận',
                      amount: '${analystInfor!.profit} coin',
                      iconPath: Assets.images.icCoinGold.keyName),
                ],
              )),
            ],
          );
  }
}
