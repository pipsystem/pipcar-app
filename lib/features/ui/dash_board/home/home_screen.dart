// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/core/presentation/bloc/internet_bloc/internet_cubit.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/image_background_widget/image_background.dart';
import 'package:pipcar/features/ui/dash_board/home/cubit/home_cubit.dart';
import 'package:pipcar/features/ui/dash_board/home/home_strings.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/di/di.dart';
import '../../../../common/themes/themes.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../components/card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final RefreshController controller = RefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => getIt.get<HomeCubit>(),
      child: Builder(builder: (context) {
        return BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state.status == InternetStatus.connected) {
              context.read<HomeCubit>().onInit();
            }
          },
          child: RefreshWidget(
            controller: controller,
            enableLoadMore: false,
            onRefresh: () async {
              context.read<HomeCubit>().onInit();
              setState(() {
                controller.refreshCompleted();
              });
            },
            child: Column(
              children: [
                _buildInforAgency(context),
                _buildActionAgency(context),
                Spacer(),
                _buildInforProcessTicket(context)
              ],
            ),
          ),
        );
      }),
    ).paddingSymmetric(
      vertical: AppDimens.paddingVertical10,
      horizontal: AppDimens.paddingHorizontalApp,
    );
  }

  /// Infor - Action

  Widget _buildInforAgency(BuildContext context) {
    Widget inforA1 = ImageBackground(
      assetPath: Assets.images.a1Background.keyName,
      width: MediaQuery.of(context).size.width / 1.8,
      height: MediaQuery.of(context).size.height / 4.5,
      boxFit: BoxFit.fitWidth,
    ).paddingTop(AppDimens.paddingMedium).center();

    Widget inforA2 = ImageBackground(
      assetPath: Assets.images.a2Background.keyName,
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 4.5,
      boxFit: BoxFit.fitWidth,
    ).paddingTop(AppDimens.paddingSmall).center();

    Widget inforA3 = ImageBackground(
      assetPath: Assets.images.a3Background.keyName,
      width: MediaQuery.of(context).size.width / 1.8,
      height: MediaQuery.of(context).size.height / 4.5,
      boxFit: BoxFit.fitWidth,
    ).paddingTop(AppDimens.paddingMedium).center();

    Widget inforA4 = ImageBackground(
      assetPath: Assets.images.a4Background.keyName,
      width: MediaQuery.of(context).size.width / 1.8,
      height: MediaQuery.of(context).size.height / 4.5,
      boxFit: BoxFit.fitWidth,
    ).paddingTop(AppDimens.paddingMedium).center();

    Widget inforA5 = ImageBackground(
      assetPath: Assets.images.a5Background.keyName,
      width: MediaQuery.of(context).size.width / 1.8,
      height: MediaQuery.of(context).size.height / 4.8,
      boxFit: BoxFit.fitWidth,
    ).paddingTop(AppDimens.paddingMedium).center();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        Widget infor = const Column();
        switch (state.agencyInfor?.agencyType) {
          case "A1":
            infor = inforA1;
            break;
          case "A2":
            infor = inforA2;
            break;
          case "A3":
            infor = inforA3;
            break;
          case "A4":
            infor = inforA4;
            break;
          case "A5":
            infor = inforA5;
            break;
          default:
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [infor],
        ).paddingTop(AppDimens.appBarHeight)
         .paddingBottom(AppDimens.paddingMedium)
         .paddingLeft(10.w);
      },
    );
  }

  Widget _buildActionAgency(BuildContext context) {
    Widget passSchedule = ButtonStyle1(
        prefixIcon: ImageAppWidget(
          height: AppDimens.buttonIconSize24,
          path: Assets.images.icSchedulePass.keyName,
          color: AppColor.primaryColor,
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
        title: "Danh sách lịch pass",
        subtitle: "Gợi ý xe theo vị trí và thời gian đón khách",
        onPressed: () => context.router.pushNamed(Routes.passSchedule));

    Widget mySchedule = ButtonStyle1(
        prefixIcon: ImageAppWidget(
          height: AppDimens.buttonIconSize,
          path: Assets.images.icCars.keyName,
          color: AppColor.primaryColor,
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
        title: "Lịch của tôi",
        subtitle: "Lịch giao của tôi",
        onPressed: () => context.router.pushNamed(Routes.mySchedule));

    Widget systemSchedule = ButtonStyle1(
        prefixIcon: ImageAppWidget(
          height: AppDimens.buttonIconSize24,
          path: Assets.images.icScheduleSystem.keyName,
          color: AppColor.primaryColor,
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
        title: "Lịch mới hệ thống",
        subtitle: "Gợi ý lịch phù hợp theo vị trí và loại xe",
        onPressed: () => context.router.pushNamed(Routes.sytemSchedule));

    Widget search = ButtonStyle1(
      prefixIcon: ImageAppWidget(
        height: AppDimens.buttonIconSize,
        path: Assets.images.icSearch.keyName,
        color: AppColor.primaryColor,
      ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
      title: HomeStrings.findCar,
      subtitle: HomeStrings.findCarWithLocation,
      onPressed: () => context.router.pushNamed(Routes.search),
    );

    Widget dispatch = ButtonStyle1(
        prefixIcon: ImageAppWidget(
          path: Assets.images.icDispatch.keyName,
          color: AppColor.primaryColor,
          height: AppDimens.buttonIconSize24,
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
        title: "Phân công xe",
        subtitle: "Giao xe cho lái xe để nhận lịch",
        onPressed: () => context.router.pushNamed(Routes.listDispatch));

    Widget listCustomer = ButtonStyle1(
        prefixIcon: const Icon(
          Icons.person_outline_outlined,
          color: AppColor.primaryColor,
        ).paddingSymmetric(horizontal: AppDimens.paddingSmall),
        title: "Danh sách khách hàng",
        subtitle: "Quản trị khách hàng",
        onPressed: () => context.router.push(ListCustomersRoute()));

    List<Widget> _a3Action = [systemSchedule, mySchedule, passSchedule];
    List<Widget> _a1Action = [passSchedule, search];
    List<Widget> _a4Action = [passSchedule];
    List<Widget> _a2Action = [dispatch, passSchedule];
    List<Widget> _a5Action = [dispatch, systemSchedule, mySchedule, passSchedule];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<Widget> listAction = [];
        switch (state.agencyInfor?.agencyType) {
          case "A1":
            listAction = _a1Action;
            break;
          case "A2":
            listAction = _a2Action;
            break;
          case "A3":
            listAction = _a3Action;
            break;
          case "A4":
            listAction = _a4Action;
            break;
          case "A5":
            listAction = _a5Action;
            break;
          default:
        }
        return Column(children: listAction);
      },
    );
  }

  Widget _buildInforProcessTicket(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if(((state.agencyInfor?.agencyType == "A3") || (state.agencyInfor?.agencyType == "A4") || (state.agencyInfor?.agencyType == "A5")) && state.currentTicketId != null){
          return Container(
            padding: EdgeInsets.only(left: AppDimens.paddingMedium),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppDimens.borderSmall),
              border: Border.all(color: AppColor.primaryColor, width: 0.5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageAppWidget(
                  height: 25.h,
                  path: Assets.images.icAlert.keyName,
                  color: AppColor.primaryColor,
                ).paddingTop(AppDimens.paddingSmall).paddingBottom(AppDimens.paddingSmall).paddingRight(AppDimens.paddingSmall),
                Column(
                  children: [
                    StyleLabel(
                      title: "Chuyến xe cần trả khách",
                      style: ThemeText.note.copyWith(height: 2, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Spacer(),
                ImageAppWidget(
                  height: 24.h,
                  path: Assets.images.icArrowRight2.keyName,
                  color: AppColor.primaryColor,
                ).paddingRight(AppDimens.paddingMedium),
              ],
            ),
          ).onTap(() {
            context.router.push(MySchedulePageRoute());
            context.router.push(MyAcceptedDetailsPageRoute(ticketId: state.currentTicketId!));
            });
        }else{
          return Row();
        }
      },
    );
  }
}
