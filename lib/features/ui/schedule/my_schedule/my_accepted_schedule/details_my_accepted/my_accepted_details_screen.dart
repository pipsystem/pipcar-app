// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/schedule/widgets/item_supplier_schedule.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../../widgets/card_view_blue.dart';
import 'cubit/my_accepted_details_cubit.dart';

@RoutePage()
class MyAcceptedDetailsPageProvider extends StatelessWidget {
  final DriverDeleveringEntity? driver;
  final String ticketId;
  const MyAcceptedDetailsPageProvider({
    Key? key,
    this.driver,
    required this.ticketId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<MyAcceptedDetailsCubit>(),
      child: MyAcceptedDetailsScreen(ticketId: ticketId),
    );
  }
}

class MyAcceptedDetailsScreen extends StatefulWidget {
  final DriverDeleveringEntity? driver;
  final String ticketId;
  const MyAcceptedDetailsScreen({
    Key? key,
    this.driver,
    required this.ticketId,
  }) : super(key: key);

  @override
  State<MyAcceptedDetailsScreen> createState() =>
      _MyAcceptedDetailsScreenState();
}

class _MyAcceptedDetailsScreenState extends State<MyAcceptedDetailsScreen> {
  @override
  void initState() {
    context
        .read<MyAcceptedDetailsCubit>()
        .getDetailsMyAcceptedTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<MyAcceptedDetailsCubit>();
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<MyAcceptedDetailsCubit, MyAcceptedDetailsState>(
        listener: (context, state) {
          if (state.status == MyAcceptedDetailsStatus.dropOff) {
            context.pop();
            context.pop();
            context.router.pushAll([
              MySchedulePageRoute(driver: widget.driver, initialPage: 1),
              MyDropOffDetailsPageRoute(ticketId: widget.ticketId)
            ]);
          } else if (state.status == MyAcceptedDetailsStatus.pickUp) {
            bloc.getDetailsMyAcceptedTicket(widget.ticketId);
          } else if (state.status == MyAcceptedDetailsStatus.deleteNavigate) {
            context.pop();
            context.pop();
            context.router.push(MySchedulePageRoute(driver: widget.driver));
          }
        },
        builder: (context, state) {
          if (state.status != MyAcceptedDetailsStatus.loaded) {
            return const ShimmerLoading();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    ItemSupplierSchedule(
                      ticket: state.details!.ticketInfor,
                      isShowTts: false,
                      fullContent: true,
                      onDeleteTicketNavigate: () => context
                          .read<DialogBloc>()
                          .showOptionDialog(
                              message: "Bạn có chắc chắn muốn hủy lịch? ",
                              acceptAction: () => context
                                  .read<MyAcceptedDetailsCubit>()
                                  .deleteTicketNavigate(widget.ticketId)),
                    ).paddingBottom(AppDimens.paddingMedium),
                    Visibility(
                      child: ButtonInforTicket(
                          title: state.details!.customerInfor.customerName,
                          subtitle: state.details!.customerInfor.customerPhone,
                          label: "Thông tin khách hàng",
                          buttonTitle: "Gọi",
                          iconButton: ImageAppWidget(
                              path: Assets.images.icPhone.keyName, width: 16.w).paddingTop(AppDimens.paddingVerySmall),
                          onButtonCall: () =>
                              FlutterPhoneDirectCaller.callNumber(
                                  state.details!.customerInfor.customerPhone),
                          prefixIcon: ImageAppWidget(
                            height: AppDimens.buttonIconSize,
                            path: Assets.images.icPerson.keyName,
                            color: AppColor.primaryColor,
                          ).paddingSymmetric(
                              horizontal: AppDimens.paddingSmall)),
                    ),
                    ButtonInforTicket(
                        title: state.details!.angencyInfor.name,
                        subtitle: state.details!.angencyInfor.phone,
                        label: "Thông tin chủ lịch",
                        buttonTitle: "Gọi",
                        iconButton: ImageAppWidget(
                            path: Assets.images.icPhone.keyName, width: 16.w).paddingTop(AppDimens.paddingVerySmall),
                        onButtonCall: () => FlutterPhoneDirectCaller.callNumber(
                            state.details!.customerInfor.customerPhone),
                        prefixIcon: ImageAppWidget(
                          height: AppDimens.buttonIconSize,
                          path: Assets.images.icPerson.keyName,
                          color: AppColor.primaryColor,
                        ).paddingSymmetric(horizontal: AppDimens.paddingSmall)),
                    ButtonInforTicket(
                        title: state.details!.supplier.carName,
                        subtitle: state.details!.supplier.carPlates,
                        label: "Xe của tôi",
                        prefixIcon: ImageAppWidget(
                          height: AppDimens.buttonIconSize,
                          path: Assets.images.icCars.keyName,
                          color: AppColor.primaryColor,
                        ).paddingSymmetric(horizontal: AppDimens.paddingSmall)),
                  ],
                ),
              ).expand(),
              TextButtonWidget(
                onPressed: () => state.details?.ticketInfor.status == 1
                    ? bloc.pickUpClient(widget.ticketId)
                    : bloc.dropOffTicket(widget.ticketId),
                title: state.details?.ticketInfor.status == 1
                    ? "Đón khách"
                    : "Trả khách",
                titleColor: AppColor.white,
                buttonColor: AppColor.primaryColor,
              ).paddingSymmetric(vertical: AppDimens.paddingMedium)
            ],
          );
        },
      ).paddingSymmetric(
          vertical: AppDimens.paddingMedium,
          horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}
