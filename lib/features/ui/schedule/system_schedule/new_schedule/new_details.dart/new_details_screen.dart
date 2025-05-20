import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/schedule/system_schedule/new_schedule/new_details.dart/cubit/new_details_cubit.dart';
import 'package:pipcar/features/ui/schedule/widgets/item_supplier_schedule.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../widgets/card_view_blue.dart';

@RoutePage()
class NewDetailsPageProvider extends StatelessWidget {
  final String ticketId;
  const NewDetailsPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<NewDetailsCubit>(),
      child: NewDetailsScreen(ticketId: ticketId),
    );
  }
}

class NewDetailsScreen extends StatefulWidget {
  final String ticketId;
  const NewDetailsScreen({super.key, required this.ticketId});

  @override
  State<NewDetailsScreen> createState() => _NewDetailsScreenState();
}

class _NewDetailsScreenState extends State<NewDetailsScreen> {
  @override
  void initState() {
    context.read<NewDetailsCubit>().getDetailsNewTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<NewDetailsCubit, NewDetailsState>(
        listener: (context, state) {
          if (state.status == NewDetailsStatus.applySuccess) {
            context.pop(widget.ticketId);
          }
        },
        builder: (context, state) {
          if (state.status != NewDetailsStatus.loaded) {
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
                      showStatusName: false,
                      fullContent: true,
                    ).paddingBottom(AppDimens.paddingMedium),
                    ButtonInforTicket(
                        title: state.details!.carName,
                        subtitle: state.details!.carPlates,
                        label: "Xe của tôi",
                        prefixIcon: ImageAppWidget(
                          height: AppDimens.buttonIconSize,
                          path: Assets.images.icCars.keyName,
                          color: AppColor.primaryColor,
                        ).paddingSymmetric(horizontal: AppDimens.paddingSmall)),
                    ButtonInforTicket(
                        title: "Coin",
                        subtitle: state.details!.coin.toString(),
                        label: "Số coin hiện tại",
                        prefixIcon: ImageAppWidget(
                          height: AppDimens.buttonIconSize,
                          path: Assets.images.icCoin.keyName,
                          color: AppColor.primaryColor,
                        ).paddingSymmetric(horizontal: AppDimens.paddingSmall)),
                  ],
                ),
              ).expand(),
              TextButtonWidget(
                onPressed: () => context
                    .read<NewDetailsCubit>()
                    .applyTicket(widget.ticketId),
                title: "Bổ lịch",
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
