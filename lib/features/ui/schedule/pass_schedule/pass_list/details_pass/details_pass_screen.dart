import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pipcar/core/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pipcar/core/presentation/widgets/image_app_widget/image_app.dart';
import 'package:pipcar/core/presentation/widgets/loading_widget/shimmer_loading.dart';
import 'package:pipcar/core/presentation/widgets/refresh_widget.dart';
import 'package:pipcar/core/presentation/widgets/text_widget/style_lable.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';
import 'package:pipcar/features/ui/dash_board/components/card_view.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/add_schedule/add_schedule_screen.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/add_schedule/cubit/add_schedule_cubit.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/pass_list/details_pass/car_handover_screen.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/pass_list/details_pass/cubit/details_pass_cubit.dart';
import 'package:pipcar/features/ui/schedule/widgets/item_ticket_pass.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../widgets/empty_schedule.dart';

@immutable
class DetailsPassPageProvider extends StatelessWidget {
  final String ticketId;
  const DetailsPassPageProvider({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetailsPassCubit>(),
      child: DetailsPassScreen(ticketId: ticketId),
    );
  }
}

class DetailsPassScreen extends StatefulWidget {
  final String ticketId;
  const DetailsPassScreen({super.key, required this.ticketId});

  @override
  State<DetailsPassScreen> createState() => _DetailsPassScreenState();
}

class _DetailsPassScreenState extends State<DetailsPassScreen> {
  @override
  void initState() {
    context.read<DetailsPassCubit>().getDetailsPassTicket(widget.ticketId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Chi tiết lịch",
        titleStyle: ThemeText.appBar,
      ),
      body: BlocConsumer<DetailsPassCubit, DetailsPassState>(
        listener: (context, state) {
          if (state.status == DetailsPassStatus.cancel) {
            context.router.pop(DetailsPassStatus.cancel);
            context.read<SnackbarBloc>().showSnackbar(
                translationKey: "Hủy lịch thành công",
                type: SnackBarType.success);
          }
          if (state.status == DetailsPassStatus.passAgainSuccess) {
            context.router.pop(DetailsPassStatus.passAgainSuccess);
            context.read<SnackbarBloc>().showSnackbar(
                translationKey: "Pass lại lịch thành công",
                type: SnackBarType.success);
          }
        },
        builder: (context, state) {
          if (state.status != DetailsPassStatus.loaded) {
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
                                  ItemTicketPass(
                                      ticket: state.details!.ticketInfor,
                                      fullContent: true),
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: const Icon(
                                      Icons.delete_outline_outlined,
                                      color: AppColor.red,
                                      size: 30,
                                    ).onTap(() {
                                      context.read<DialogBloc>().showOptionDialog(
                                          message:
                                              "Khi huỷ lịch, bạn sẽ không nhận được\ncoin.\n\n\nBạn có chắc chắn muốn huỷ lịch?",
                                          acceptAction: () => context
                                              .read<DetailsPassCubit>()
                                              .cancelTicket(widget.ticketId));
                                    }).paddingAll(AppDimens.paddingMedium),
                                  ))
                                ],
                              ).paddingBottom(AppDimens.paddingMedium),
                              StyleLabel(
                                title: "Danh sách xe đang bổ",
                                style: ThemeText.body2.copyWith(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontType.semiBold,
                                ),
                              ).paddingBottom(AppDimens.paddingSmall),
                              state.details!.suppliers.isEmpty
                                  ? SizedBox(
                                    height: MediaQuery.of(context).size.height / 10,
                                    child: const EmptyListCar()
                                  )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height / 3,
                                      child: RefreshWidget(
                                        onRefresh: () => context.read<DetailsPassCubit>().getDetailsPassTicket(widget.ticketId),
                                        enableLoadMore: false,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              state.details!.suppliers.length,
                                          itemBuilder: (context, index) =>
                                              ButtonStyle2(
                                                  prefixIcon: ImageAppWidget(
                                                    height: AppDimens.buttonIconSize,
                                                    path: Assets.images.icCars.keyName,
                                                    color:AppColor.primaryColor,
                                                  ).paddingSymmetric(
                                                      horizontal: AppDimens.paddingVerySmall),
                                                  title: state.details!.suppliers[index].carName,
                                                  subtitle: state.details!.suppliers[index].carPlates,
                                                  onPressed: () =>
                                                      BlocProvider.value(
                                                          value: context.read<DetailsPassCubit>(),
                                                          child: CarHandover(
                                                            cars: state.details!.suppliers,
                                                            selectCar: state.details!.suppliers[index],
                                                            ticketId: state.details!.ticketInfor.ticketId,
                                                          )).launch(context)),
                                        ),
                                      ),
                                    )
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
                            "Khi pass lại lịch, lịch hiện tại sẽ bị huỷ\n\nBạn có đồng ý pass lại không? ",
                        acceptAction: () async {
                          await context.router.push(AddSchedulePageRoute(
                              ticketDetails: state.details, isPassAgain: true));
                          context.router.pop();
                          context.read<DetailsPassCubit>().passAgain();
                        },
                      );
                },
                title: "Pass lại lịch",
                titleColor: AppColor.white,
                buttonColor: AppColor.primaryColor,
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
