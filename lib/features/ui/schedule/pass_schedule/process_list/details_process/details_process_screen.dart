import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pipcar/core/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pipcar/core/presentation/widgets/image_app_widget/image_app.dart';
import 'package:pipcar/core/presentation/widgets/loading_widget/shimmer_loading.dart';
import 'package:pipcar/features/domain/enterties/car_entity.dart';
import 'package:pipcar/features/ui/dash_board/components/card_view.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/process_list/details_process/cubit/details_process_cubit.dart';
import 'package:pipcar/features/ui/schedule/widgets/card_view_blue.dart';
import 'package:pipcar/features/ui/schedule/widgets/item_ticket_process.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/routers/app_router.dart';
import '../../../../../../core/presentation/widgets/button_widget/text_button_widget.dart';
import '../../../../../domain/enterties/car_entity.dart';

@RoutePage()
class DetailsProcessPageProvider extends StatelessWidget {
  final String ticketId;
  const DetailsProcessPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetailsProcessCubit>(),
      child: DetailsProcessScreen(ticketId: ticketId),
    );
  }
}

class DetailsProcessScreen extends StatefulWidget {
  final String ticketId;
  const DetailsProcessScreen({super.key, required this.ticketId});

  @override
  State<DetailsProcessScreen> createState() => _DetailsProcessScreenState();
}

class _DetailsProcessScreenState extends State<DetailsProcessScreen> {
  @override
  void initState() {
    context
        .read<DetailsProcessCubit>()
        .getDetailsProcessTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<DetailsProcessCubit, DetailsProcessState>(
        listener: (context, state) {
          if (state.status == DetailsProcessStatus.completeSuccess) {
            context.router.pop(DetailsProcessStatus.completeSuccess);
          }
        },
        builder: (context, state) {
          final blocDetailsProcess = context.read<DetailsProcessCubit>();
          if (state.status != DetailsProcessStatus.loaded) {
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
                        ItemTicketProcess(
                                ticket: state.details!.ticketInfor,
                                fullContent: true)
                            .paddingBottom(AppDimens.paddingMedium),
                      ],
                    ).paddingBottom(AppDimens.paddingMedium),
                    ButtonInforTicket(
                      title: state.details!.cusomerInfor.customerName,
                      subtitle: state.details!.cusomerInfor.customerPhone,
                      label: "Thông tin khách hàng",
                    ),
                    state.details!.suppliers.isNotEmpty
                        ? ButtonInforTicket(
                            title: state.details!.suppliers[0].supplierName,
                            subtitle: state.details!.suppliers[0].supplierPhone,
                            label: "Thông tin lái xe",
                          )
                        : const SizedBox(),
                    state.details!.suppliers.isNotEmpty
                        ? ButtonStyle2(
                            hasAction: false,
                            title: state.details!.suppliers[0].carName,
                            subtitle: state.details!.suppliers[0].carPlates,
                            // label: "Thông tin xe",
                            prefixIcon: ImageAppWidget(
                              height: AppDimens.buttonIconSize,
                              path: Assets.images.icCars.keyName,
                              color: AppColor.primaryColor,
                            ).paddingSymmetric(
                                horizontal: AppDimens.paddingSmall),
                            onPressed: () => context.router.push(
                                DetailsCarPageRoute(
                                    car: CarEntity(
                                        agencyId:
                                            state.details!.suppliers[0].id,
                                        id: state.details!.suppliers[0].id,
                                        carName:
                                            state.details!.suppliers[0].carName,
                                        carPlates: state
                                            .details!.suppliers[0].carPlates,
                                        carLat:
                                            state.details!.suppliers[0].carLat,
                                        carLong:
                                            state.details!.suppliers[0].carLong,
                                        timeUpdate: state
                                            .details!.suppliers[0].timeUpdate,
                                        carTypeName: state
                                            .details!.suppliers[0].carName))))
                        : const SizedBox(),
                  ],
                ),
              ).expand(),
              state.details!.ticketInfor.status == 4
                  ? TextButtonWidget(
                      onPressed: () =>
                          blocDetailsProcess.completeTicket(widget.ticketId),
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
