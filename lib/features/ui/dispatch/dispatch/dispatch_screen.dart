import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/features/domain/enterties/dispatch/infor_driver_dispatch_entity.dart';
import 'package:pipcar/features/ui/dispatch/dispatch/cubit/dispatch_cubit.dart';
import 'package:pipcar/features/ui/dispatch/widget/infor_currency.dart';
import 'package:pipcar/features/ui/schedule/widgets/card_view_blue.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/routers/app_router.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../dash_board/components/card_view.dart';

part 'dispatch_widget.dart';

class DispatchScreen extends StatefulWidget {
  final DriverDeleveringEntity driver;
  const DispatchScreen({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  State<DispatchScreen> createState() => _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen> {
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    context
        .read<DispatchCubit>()
        .getDetailsDriverDispatch(widget.driver.agencyId);
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
          title: widget.driver.driverName,
          titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              FlutterPhoneDirectCaller.callNumber(widget.driver.driverPhone),
          backgroundColor: AppColor.white,
          elevation: 0.0,
          shape:
              const StadiumBorder(side: BorderSide(color: AppColor.lightGrey)),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.call,
                color: AppColor.green,
                size: AppDimens.iconMediumSize,
              ),
              StyleLabel(
                title: " Gọi",
                style: ThemeText.body2.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
        body: RefreshWidget(
          controller: _controller,
          enableLoadMore: false,
          onRefresh: () {
            context
                .read<DispatchCubit>()
                .getDetailsDriverDispatch(widget.driver.agencyId);

            setState(() {
              _controller.refreshCompleted();
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentTicketBlock(
                infor: context.watch<DispatchCubit>().state.driverInfor,
              ),
              SizedBox(height: 10.h),
              CardFormView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 22.w),
                      InforCar(
                        name: widget.driver.carName,
                        plates: widget.driver.carPlate,
                        carTypeId: 1,
                      ).expand(),
                      Container(
                        color: AppColor.primaryColor,
                        width: 2,
                        height: 55.h,
                      ),
                      InforCurrency(
                              title: 'Doanh thu',
                              amount:
                                  '${context.watch<DispatchCubit>().state.driverInfor?.currentMonth ?? '...'} coin',
                              iconPath: Assets.images.icCoinGold.keyName)
                          .onTap(() => context.router.push(
                              SalaryMonthStatisticRoute(
                                  supplierId: widget.driver.agencyId)))
                          .expand(),
                      SizedBox(width: 22.w),
                    ],
                  ),
                  const MySeparator(color: AppColor.lightGrey),
                  ListServiceDispatch(driver: widget.driver)
                ],
              )),
            ],
          ),
        ));
  }
}
