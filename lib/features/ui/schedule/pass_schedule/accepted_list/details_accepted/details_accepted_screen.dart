import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/domain/enterties/car_entity.dart';
import 'package:pipcar/features/ui/schedule/widgets/item_ticket_accepted.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';

import '../../../../../../core/presentation/routers/app_router.dart';
import '../../../../dash_board/components/card_view.dart';
import '../../../widgets/card_view_blue.dart';
import 'cubit/details_accepted_cubit.dart';

@RoutePage()
class DetailsAcceptedPageProvider extends StatelessWidget {
  final String ticketId;
  const DetailsAcceptedPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetailsAcceptedCubit>(),
      child: DetailsAcceptedScreen(ticketId: ticketId),
    );
  }
}

class DetailsAcceptedScreen extends StatefulWidget {
  final String ticketId;
  const DetailsAcceptedScreen({super.key, required this.ticketId});

  @override
  State<DetailsAcceptedScreen> createState() => _DetailsAcceptedScreenState();
}

class _DetailsAcceptedScreenState extends State<DetailsAcceptedScreen> {
  @override
  void initState() {
    context
        .read<DetailsAcceptedCubit>()
        .getDetailsAcceptedTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<DetailsAcceptedCubit, DetailsAcceptedState>(
        listener: (context, state) {
          if (state.status == DetailsAcceptedStatus.cancel) {
            context.router.pop(DetailsAcceptedStatus.cancel);
            context.read<SnackbarBloc>().showSnackbar(
                translationKey: "Hủy lịch thành công",
                type: SnackBarType.success);
          } else if (state.status == DetailsAcceptedStatus.completeSuccess) {
            context.router.pop(widget.ticketId);
          }
        },
        builder: (context, state) {
          final blocDetailsAccept = context.read<DetailsAcceptedCubit>();

          if (state.status != DetailsAcceptedStatus.loaded) {
            return const ShimmerLoading();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Stack(
                      children: [
                        ItemTicketAccepted(
                            ticket: state.details!.ticketInfor,
                            fullContent: true),
                        state.details!.ticketInfor.status == 1
                            ? Positioned.fill(
                                child: Align(
                                alignment: Alignment.bottomRight,
                                child: const Icon(
                                  Icons.delete_outline_outlined,
                                  color: AppColor.red,
                                  size: 30,
                                ).onTap(() {
                                  context.read<DialogBloc>().showOptionDialog(
                                      message:
                                          "Bạn có chắc chắn muốn hủy lịch? \nKhi hủy lịch, bạn sẽ không nhận được coin.",
                                      acceptAction: () => blocDetailsAccept
                                          .cancelTicket(widget.ticketId));
                                }).paddingAll(AppDimens.paddingMedium),
                              ))
                            : const SizedBox(),
                      ],
                    ).paddingBottom(AppDimens.paddingMedium),
                    ButtonInforTicket(
                      title: state.details!.cusomerInfor.customerName,
                      subtitle: state.details!.cusomerInfor.customerPhone,
                      label: "Thông tin khách hàng",
                      buttonTitle: state.details!.ticketInfor.status == 1
                          ? "Cập nhật"
                          : null,
                      onButtonCall: () {
                        blocDetailsAccept.phoneCustomerController.text =
                            state.details?.cusomerInfor.customerPhone ?? "";
                        blocDetailsAccept.nameCustomerController.text =
                            state.details?.cusomerInfor.customerName ?? "";
                        FormEditInforCustomer.showFormEdit(context);
                      },
                      iconButton: Icon(Icons.edit,
                          color: AppColor.primaryColor, size: 20.sp),
                    ),
                    state.details!.suppliers.isNotEmpty ? ButtonInforTicket(
                      title: state.details!.suppliers[0].supplierName,
                      subtitle: state.details!.suppliers[0].supplierPhone,
                      label: "Thông tin lái xe",
                      buttonTitle: "Gọi",
                      iconButton: ImageAppWidget(
                          path: Assets.images.icPhone.keyName, width: 16.w).paddingTop(AppDimens.paddingVerySmall),
                      onButtonCall: () => FlutterPhoneDirectCaller.callNumber(
                          state.details!.suppliers[0].supplierPhone),
                    ) : const SizedBox(),
                    state.details!.suppliers.isNotEmpty ? ButtonStyle2(
                        title: state.details!.suppliers[0].carName,
                        subtitle: state.details!.suppliers[0].carPlates,
                        // label: "Thông tin xe",
                        prefixIcon: ImageAppWidget(
                          height: AppDimens.buttonIconSize,
                          path: Assets.images.icCars.keyName,
                          color: AppColor.primaryColor,
                        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
                        onPressed: () => context.router.push(
                            DetailsCarPageRoute(
                                car: CarEntity(
                                    agencyId: state.details!.suppliers[0].id,
                                    id: state.details!.suppliers[0].id,
                                    carName:
                                        state.details!.suppliers[0].carName,
                                    carPlates:
                                        state.details!.suppliers[0].carPlates,
                                    carLat: state.details!.suppliers[0].carLat,
                                    carLong:
                                        state.details!.suppliers[0].carLong,
                                    timeUpdate:
                                        state.details!.suppliers[0].timeUpdate,
                                    carTypeName:
                                        state.details!.suppliers[0].carName))))
                        : const SizedBox(),
                  ],
                ),
              ).expand(),
              state.details!.ticketInfor.status == 4
                  ? TextButtonWidget(
                      onPressed: () =>
                          blocDetailsAccept.completeTicket(widget.ticketId),
                      title: "Hoàn thành",
                      titleColor: AppColor.white,
                      buttonColor: AppColor.primaryColor,
                    ).paddingSymmetric(vertical: AppDimens.paddingMedium)
                  : const SizedBox()
            ],
          );
        },
      ).paddingSymmetric(
          vertical: AppDimens.paddingMedium,
          horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}
