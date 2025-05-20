import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/themes/theme_color.dart';
import 'package:pipcar/common/themes/theme_text.dart';
import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/detail_driver/cubit/details_driver_cubit.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/detail_driver/loaction_car_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailsDriverScreen extends StatefulWidget {
  final String agencyId;
  final String carId;
  final String driverId;

  const DetailsDriverScreen({super.key, required this.agencyId, required this.carId, required this.driverId});

  @override
  State<DetailsDriverScreen> createState() => _DetailsDriverScreenState();
}
class _DetailsDriverScreenState extends State<DetailsDriverScreen>{
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    context.read<DetailsDriverCubit>().getDetailsDriver(widget.agencyId);
    context.read<DetailsDriverCubit>().getListCar();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appbar: AppBarWidget(
        title: "Chi tiết lái xe",
        titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
      ),
      body: RefreshWidget(
          controller: _controller,
          enableLoadMore: false,
          onRefresh: () {
            context.read<DetailsDriverCubit>().getDetailsDriver(widget.agencyId);
            setState(() {
              _controller.refreshCompleted();
            });
          },
          child: 
      context.watch<DetailsDriverCubit>().state.driver != null
      ? Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: AppColor.dividerColor
              )
            ),
            child: Column(
              children: [
                ImageAppWidget(
                  path: context.read<DetailsDriverCubit>().state.driver!.avatar != '' ? context.read<DetailsDriverCubit>().state.driver!.avatar : Assets.images.defaultAvt.keyName,
                  height: MediaQuery.of(context).size.height / 2.3,
                  width: MediaQuery.of(context).size.width,
                ).paddingBottom(AppDimens.paddingMedium),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StyleLabel(
                            title: context.read<DetailsDriverCubit>().state.driver!.name,
                            style: ThemeText.body1.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StyleLabel(
                            title: context.read<DetailsDriverCubit>().state.driver!.phone,
                            style: ThemeText.style12Regular.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ).paddingLeft(AppDimens.paddingMedium),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StyleLabel(
                            title: context.read<DetailsDriverCubit>().state.driver!.carPlate,
                            style: ThemeText.body1.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StyleLabel(
                            title: context.read<DetailsDriverCubit>().state.driver!.carName,
                            style: ThemeText.style12Regular.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColor.dividerColor),
                          )
                        )
                      ],
                    ).paddingRight(AppDimens.paddingMedium)
                  ],
                ).paddingBottom(AppDimens.paddingLarge),
              ],
            )
          ).paddingTop(AppDimens.paddingVeryLarge).paddingBottom(AppDimens.paddingLarge),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.dividerColor),
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ImageAppWidget(
                      path: Assets.images.icPlace.keyName,
                      height: AppDimens.buttonIconSize24,
                    ),
                    StyleLabel(
                      title: "Xem vị trí",
                      style: ThemeText.style12Regular.copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ).paddingRight(AppDimens.paddingMedium).onTap(() async {
                  await context.read<DetailsDriverCubit>().getLocationCar(widget.driverId);
                  if(context.read<DetailsDriverCubit>().state.location != null){
                  log(context.read<DetailsDriverCubit>().state.location!.updateTime);
                    BlocProvider.value(
                                value: context.read<DetailsDriverCubit>(),
                                child: LocationCarScreen(
                                  driver: context.read<DetailsDriverCubit>().state.driver!,
                                  location: context.read<DetailsDriverCubit>().state.location!,
                                  driverId: widget.driverId,
                                )).launch(context);
                  }else{
                    getIt.get<DialogBloc>().showAlertDialog(
                      title: "Thông báo",
                      mainMessage: "Chưa có vị trí xe",
                      message: "${context.read<DetailsDriverCubit>().state.driver!.carName}\n${context.read<DetailsDriverCubit>().state.driver!.carPlate}\n${context.read<DetailsDriverCubit>().state.driver!.name}\n${context.read<DetailsDriverCubit>().state.driver!.phone}"
                    );
                  }
                }),
                Column(
                  children: [
                    ImageAppWidget(
                      path: Assets.images.icLocalPhone.keyName,
                      height: AppDimens.buttonIconSize24,
                    ),
                    StyleLabel(
                      title: "Gọi lái xe",
                      style: ThemeText.style12Regular.copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ).paddingSymmetric(horizontal: AppDimens.paddingMedium).onTap(() => FlutterPhoneDirectCaller.callNumber(context.read<DetailsDriverCubit>().state.driver!.phone)),
                Column(
                  children: [
                    ImageAppWidget(
                      path: Assets.images.icCopy.keyName,
                      height: AppDimens.buttonIconSize24,
                    ),
                    StyleLabel(
                      title: "Copy mã",
                      style: ThemeText.style12Regular.copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                ).paddingLeft(AppDimens.paddingLarge).onTap(
                  () {
                    if(context.read<DetailsDriverCubit>().state.driver!.agencyCode != ''){
                      FlutterClipboard.copy(context.read<DetailsDriverCubit>().state.driver!.agencyCode);
                      AppUtils.showToast("Đã copy mã");
                    }else{
                      AppUtils.showToast("Chưa có mã hoặc mã đã thay đổi");
                    }
                  }
                ),
              ],
            ).paddingOnly(top: AppDimens.paddingLarge, bottom: AppDimens.paddingLarge),
          )
        ],
      )
      : ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 6,
          itemBuilder: (context, index) => SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height / 9,
                child: const ShimmerLoading()
                    .paddingBottom(AppDimens.paddingVerySmall),
              )),
      )
    );
  }
}