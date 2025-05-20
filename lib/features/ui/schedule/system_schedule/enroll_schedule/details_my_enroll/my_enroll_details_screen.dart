import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';

import 'package:pipcar/features/ui/schedule/widgets/item_supplier_schedule.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import '../../../widgets/card_view_blue.dart';
import 'cubit/my_enroll_details_cubit.dart';

@RoutePage()
class MyEnrollDetailsPageProvider extends StatelessWidget {
  final String ticketId;
  const MyEnrollDetailsPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<MyEnrollDetailsCubit>(),
      child: MyEnrollDetailsScreen(ticketId: ticketId),
    );
  }
}

class MyEnrollDetailsScreen extends StatefulWidget {
  final String ticketId;
  const MyEnrollDetailsScreen({super.key, required this.ticketId});

  @override
  State<MyEnrollDetailsScreen> createState() => _MyEnrollDetailsScreenState();
}

class _MyEnrollDetailsScreenState extends State<MyEnrollDetailsScreen> {
  @override
  void initState() {
    context
        .read<MyEnrollDetailsCubit>()
        .getDetailsMyEnrollTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<MyEnrollDetailsCubit, MyEnrollDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == MyEnrollDetailsStatus.cancel) {
            context.router.pop(MyEnrollDetailsStatus.cancel);
            context.read<SnackbarBloc>().showSnackbar(
                translationKey: "Hủy lịch bổ thành công",
                type: SnackBarType.success);
          } else if (state.status != MyEnrollDetailsStatus.loaded) {
            return const ShimmerLoading();
          }
          return Column(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimens.paddingMedium,
                      horizontal: AppDimens.paddingHorizontalApp,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ItemSupplierSchedule(
                                    ticket: state.details!.ticketInfor,
                                    isShowTts: false,
                                    fullContent: true,
                                  ),
                                ],
                              ).paddingBottom(AppDimens.paddingMedium),
                              ButtonInforTicket(
                                  title: state.details!.carName,
                                  subtitle: state.details!.carPlates,
                                  label: "Xe đang bổ lịch",
                                  prefixIcon: ImageAppWidget(
                                    height: AppDimens.buttonIconSize,
                                    path: Assets.images.icCars.keyName,
                                    color: AppColor.primaryColor,
                                  ).paddingSymmetric(
                                      horizontal: AppDimens.paddingSmall)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).expand(),
              TextButtonWidget(
                onPressed: () {
                  context.read<DialogBloc>().showOptionDialog(
                      message:
                          "Khi huỷ bổ lịch, bạn sẽ không thấy\nlịch này nữa.\n\nBạn có chắc chắn muốn hủy bổ lịch?",
                      acceptAction: () => context
                          .read<MyEnrollDetailsCubit>()
                          .cancelApply(widget.ticketId));
                },
                title: "huỷ bổ lịch",
                titleColor: AppColor.white,
                buttonColor: AppColor.cancelColor,
              ).paddingSymmetric(
                  vertical: AppDimens.paddingLarge,
                  horizontal: AppDimens.paddingMedium)
            ],
          );
        },
      ),
    );
  }
}
