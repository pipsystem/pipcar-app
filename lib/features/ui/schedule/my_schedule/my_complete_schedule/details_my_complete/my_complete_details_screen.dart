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
import 'cubit/my_complete_details_cubit.dart';

@RoutePage()
class MyCompleteDetailsPageProvider extends StatelessWidget {
  final String ticketId;
  const MyCompleteDetailsPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<MyCompleteDetailsCubit>(),
      child: MyCompleteDetailsScreen(ticketId: ticketId),
    );
  }
}

class MyCompleteDetailsScreen extends StatefulWidget {
  final String ticketId;
  const MyCompleteDetailsScreen({super.key, required this.ticketId});

  @override
  State<MyCompleteDetailsScreen> createState() =>
      _MyCompleteDetailsScreenState();
}

class _MyCompleteDetailsScreenState extends State<MyCompleteDetailsScreen> {
  @override
  void initState() {
    context
        .read<MyCompleteDetailsCubit>()
        .getDetailsMyCompleteTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<MyCompleteDetailsCubit, MyCompleteDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status != MyCompleteDetailsStatus.loaded) {
            return const ShimmerLoading();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              ItemSupplierSchedule(
                ticket: state.details!.ticketInfor,
                isShowTts: false,
                fullContent: true,
              ).paddingBottom(AppDimens.paddingMedium),
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
          );
        },
      ).paddingSymmetric(
          vertical: AppDimens.paddingMedium,
          horizontal: AppDimens.paddingHorizontalApp),
    );
  }
}
