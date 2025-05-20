import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

import 'package:pipcar/features/ui/schedule/widgets/item_supplier_schedule.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../widgets/card_view_blue.dart';
import 'cubit/my_drop_off_details_cubit.dart';

@RoutePage()
class MyDropOffDetailsPageProvider extends StatelessWidget {
  final String ticketId;
  const MyDropOffDetailsPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<MyDropOffDetailsCubit>(),
      child: MyDropOffDetailsScreen(ticketId: ticketId),
    );
  }
}

class MyDropOffDetailsScreen extends StatefulWidget {
  final String ticketId;
  const MyDropOffDetailsScreen({super.key, required this.ticketId});

  @override
  State<MyDropOffDetailsScreen> createState() => _MyDropOffDetailsScreenState();
}

class _MyDropOffDetailsScreenState extends State<MyDropOffDetailsScreen> {
  @override
  void initState() {
    context
        .read<MyDropOffDetailsCubit>()
        .getDetailsMyDropOffTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<MyDropOffDetailsCubit, MyDropOffDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == MyDropOffDetailsStatus.dropOff) {
            context
                .read<MyDropOffDetailsCubit>()
                .getDetailsMyDropOffTicket(widget.ticketId);
          }
          if (state.status != MyDropOffDetailsStatus.loaded) {
            return const ShimmerLoading();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12.h),
                ItemSupplierSchedule(
                  ticket: state.details!.ticketInfor,
                  isShowTts: state.details!.ticketInfor.status == 1,
                  fullContent: true,
                ).paddingBottom(AppDimens.paddingMedium),
                Visibility(
                  visible: state.details!.ticketInfor.status == 1,
                  child: ButtonInforTicket(
                      title: state.details!.customerInfor.customerName,
                      subtitle: state.details!.customerInfor.customerPhone,
                      label: "Thông tin khách hàng",
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
          );
        },
      ).paddingSymmetric(
          vertical: AppDimens.paddingMedium,
          horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}
