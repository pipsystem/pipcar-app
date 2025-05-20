import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/schedule/widgets/item_ticket_Accepted.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';

import '../../../widgets/card_view_blue.dart';
import 'cubit/details_complete_cubit.dart';

@RoutePage()
class DetailsCompletePageProvider extends StatelessWidget {
  final String ticketId;
  const DetailsCompletePageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetailsCompleteCubit>(),
      child: DetailsCompleteScreen(ticketId: ticketId),
    );
  }
}

class DetailsCompleteScreen extends StatefulWidget {
  final String ticketId;
  const DetailsCompleteScreen({super.key, required this.ticketId});

  @override
  State<DetailsCompleteScreen> createState() => _DetailsCompleteScreenState();
}

class _DetailsCompleteScreenState extends State<DetailsCompleteScreen> {
  @override
  void initState() {
    context
        .read<DetailsCompleteCubit>()
        .getDetailsCompleteTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<DetailsCompleteCubit, DetailsCompleteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status != DetailsCompleteStatus.loaded) {
            return const ShimmerLoading();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              ItemTicketAccepted(
                      ticket: state.details!.ticketInfor, fullContent: true)
                  .paddingBottom(AppDimens.paddingMedium),
              ButtonInforTicket(
                title: state.details!.cusomerInfor.customerName,
                subtitle: state.details!.cusomerInfor.customerPhone,
                label: "Thông tin khách hàng",
                iconButton:
                    Icon(Icons.edit, color: AppColor.primaryColor, size: 20.sp),
              ),
              ButtonInforTicket(
                title: state.details!.suppliers[0].supplierName,
                subtitle: state.details!.suppliers[0].supplierPhone,
                label: "Thông tin lái xe",
                buttonTitle: "Gọi",
                iconButton: ImageAppWidget(
                    path: Assets.images.icPhone.keyName, width: 16.w).paddingTop(AppDimens.paddingVerySmall),
                onButtonCall: () => FlutterPhoneDirectCaller.callNumber(
                    state.details!.suppliers[0].supplierPhone),
              ),
              ButtonInforTicket(
                  title: state.details!.suppliers[0].carName,
                  subtitle: state.details!.suppliers[0].carPlates,
                  label: "Thông tin xe",
                  prefixIcon: ImageAppWidget(
                    height: AppDimens.buttonIconSize,
                    path: Assets.images.icCars.keyName,
                    color: AppColor.primaryColor,
                  ).paddingSymmetric(horizontal: AppDimens.paddingSmall)),
            ],
          );
        },
      ).paddingSymmetric(
          vertical: AppDimens.paddingMedium,
          horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}
