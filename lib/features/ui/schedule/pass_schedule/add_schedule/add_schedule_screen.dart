import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/features/domain/enterties/ticket/details_ticket.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/add_schedule/config_address_add_schedule/config_district_add_schedule_screen.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/add_schedule/config_address_add_schedule/config_provice_add_schedule_screen.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/add_schedule/cubit/add_schedule_cubit.dart';

import '../../../../../common/assets/assets.gen.dart';
import '../../../../../common/di/di.dart';
import '../../../../../common/themes/themes.dart';
import '../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import '../../../../../core/presentation/widgets/widgets.dart';

@RoutePage()
class AddSchedulePageProvider extends StatelessWidget {
  final DetailsPassTicket? ticketDetails;
  final bool? isPassAgain;
  const AddSchedulePageProvider({super.key, this.ticketDetails, this.isPassAgain});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AddScheduleCubit>()
        ..ticketDetails = ticketDetails
        ..onInit(),
      child: AddScheduleScreen(isPassAgain: isPassAgain, ticketDetails: ticketDetails,),
    );
  }
}

class AddScheduleScreen extends StatefulWidget {
  final DetailsPassTicket? ticketDetails;
  final bool? isPassAgain;
  const AddScheduleScreen({super.key, this.isPassAgain, this.ticketDetails});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isCanceledOldTicket = false;
    if(widget.isPassAgain == true && widget.ticketDetails != null) {
      context.read<AddScheduleCubit>().ticketDetails = widget.ticketDetails;
      log(context.read<AddScheduleCubit>().ticketDetails!.ticketInfor.ticketId);
    }
    return Scaffold(
      appBar: widget.isPassAgain != true
        ? AppBarWidget(title: "Pass lịch", titleStyle: ThemeText.appBar)
        : AppBarWidget(title: "Pass lịch", titleStyle: ThemeText.appBar, isReload: true, reloadAction: (){
                    context.router.pop();
                    context.router.pushNamed(Routes.passSchedule);
        },),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: AppDimens.paddingMedium),
            SingleChildScrollView(
              child: BlocConsumer<AddScheduleCubit, AddScheduleState>(
                listener: (context, state) {
                  if (state.status ==
                      AddScheduleStatus.createTicketSuccessful) {
                    context.router
                        .pop(AddScheduleStatus.createTicketSuccessful);
                    getIt.get<SnackbarBloc>().showSnackbar(
                        translationKey: "Pass lịch thành công",
                        type: SnackBarType.success);
                  }
                  if (state.status ==
                      AddScheduleStatus.cancelOldTicketSuccessful && isCanceledOldTicket == false) {
                        isCanceledOldTicket = true;
                    getIt.get<SnackbarBloc>().showSnackbar(
                        translationKey: "Huỷ lịch thành công",
                        type: SnackBarType.success);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      AppDimens.sizedBoxHeight10,
                      _buildContentSchedule(context),
                      _buildCarType(context),
                      _buildCoinFomr(context),
                      _buildAddress(context),
                      _buildPickUpTime(context),
                    ],
                  );
                },
              ),
            ).expand(),
            TextButtonWidget(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (formKey.currentState!.validate()) {
                  context.read<AddScheduleCubit>().createTicket();
                }
              },
              title: "Pass lịch",
              titleColor: AppColor.white,
              buttonColor: AppColor.primaryColor,
            ).paddingSymmetric(vertical: AppDimens.paddingVerticalApp)
          ],
        ),
      ).paddingSymmetric(horizontal: AppDimens.paddingHorizontalApp),
    );
  }

  Widget _buildContentSchedule(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Nội dung lịch",
          style: ThemeText.body2.copyWith(fontWeight: FontType.bold),
        ).paddingBottom(AppDimens.paddingVerySmall),
        TextFieldWidget(
          controller: context.read<AddScheduleCubit>().contentController,
          hintText:
              "Nhập thông tin lịch ... vd : Xe 5 chỗ, đón sân bay VN123 về Định Công , 280k chuyển khoản",
          hintStyle:
              ThemeText.note.copyWith(color: AppColor.hintColor, height: 1.5),
          textStyle:
              ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          maxLines: 5,
          validate: (value) {
            return isNullEmpty(value)
                ? "Không được để trống nội dung lịch"
                : null;
          },
          borderColor: AppColor.hintColor,
        ).paddingBottom(AppDimens.paddingVerySmall),
      ],
    );
  }

  Widget _buildCarType(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Chọn loại xe",
          style: ThemeText.body2.copyWith(fontWeight: FontType.bold),
        ).paddingBottom(AppDimens.paddingVerySmall),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.borderCard, width: 0.5),
              borderRadius: BorderRadius.circular(AppDimens.borderSmall)),
          child: BlocBuilder<AddScheduleCubit, AddScheduleState>(
            builder: (context, state) {
              return _buildHorizontalText(
                icon: Icons.filter_list_sharp,
                title: state.carTypeName,
                isEmpty: state.province == null,
              ).onTap(() => context.showBottomSheet(
                    title: "Loại xe",
                    height: 300.h,
                    child: ListView.builder(
                        itemCount: AppConstant.listCarType.length,
                        itemBuilder: (_, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StyleLabel(
                                  textAlign: TextAlign.center,
                                  title: AppConstant.listCarType[index].name,
                                ).paddingSymmetric(vertical: 5.h),
                              ],
                            ).onTap(() {
                              context.read<AddScheduleCubit>().selectCarType(
                                  AppConstant.listCarType[index].name);
                              context.pop();
                            })).expand(),
                  ));
            },
          ),
        ).paddingBottom(AppDimens.paddingMedium),
      ],
    );
  }

  Widget _buildCoinFomr(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Số coin nhận lịch",
          style: ThemeText.body2.copyWith(fontWeight: FontType.bold),
        ).paddingBottom(AppDimens.paddingVerySmall),
        TextFieldWidget(
          controller: context.read<AddScheduleCubit>().coinController,
          keyboardType: TextInputType.number,
          textStyle:
              ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          onSaved: (_) {
            Focus.of(context).unfocus();
          },
          prefixIcon: SizedBox(
            height: 2,
            width: 2,
            child: Image.asset(
              Assets.images.icCoin.keyName,
            ).paddingSymmetric(
                horizontal: AppDimens.paddingMedium,
                vertical: AppDimens.paddingMedium),
          ),
          hintText: "Số coin nhận lịch",
          hintStyle: ThemeText.note.copyWith(
            color: AppColor.hintColor,
          ),
          borderColor: AppColor.hintColor,
        ).paddingBottom(AppDimens.paddingVerySmall),
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Chọn khu vực đón",
          style: ThemeText.body2.copyWith(fontWeight: FontType.bold),
        ).paddingBottom(AppDimens.paddingVerySmall),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.borderCard, width: 0.5),
              borderRadius: BorderRadius.circular(AppDimens.borderSmall)),
          child: BlocBuilder<AddScheduleCubit, AddScheduleState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHorizontalText(
                    icon: Icons.location_city,
                    title: state.province == null
                        ? "Tỉnh thành đón"
                        : "${state.province?.name} (Tỉnh thành đón)",
                    isEmpty: state.province == null,
                  ).onTap(() => BlocProvider.value(
                                  value: context.read<AddScheduleCubit>(),
                                  child: const ConfigProvinceAddScheduleScreen(),
                                ).launch(context)
                                  ),
                  const Divider(
                      color: AppColor.dividerColor,
                      height: 0,
                      endIndent: 20,
                      indent: 20),
                  _buildHorizontalText(
                    icon: Icons.location_city,
                    title: state.selectedDistrict == null
                        ? "Quận huyện đón"
                        : "${state.selectedDistrict?.name} (Quận huyện đón)",
                    isEmpty: state.selectedDistrict == null,
                  ).onTap(() => state.province != null
                      ? BlocProvider.value(
                                value: context.read<AddScheduleCubit>(),
                                child: const ConfigDistrictAddScheduleScreen(),
                              ).launch(context)
                      : AppUtils.showToast("Vui lòng chọn tỉnh thành đón"))
                ],
              );
            },
          ),
        ).paddingBottom(AppDimens.paddingMedium),
      ],
    );
  }

  Widget _buildPickUpTime(BuildContext context) {
    return TextFieldPickUpTime(
        controller: context.read<AddScheduleCubit>().pickUpTimeController,
        onConfirm: (date) {
          context.read<AddScheduleCubit>().selectPickUpTime(date);
        });
  }

  Widget _buildHorizontalText(
      {required IconData icon,
      required String title,
      bool enalble = true,
      bool isEmpty = false}) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: AppDimens.iconMediumSize)
            .paddingSymmetric(horizontal: 6.w),
        StyleLabel(
            title: title,
            style: ThemeText.note.copyWith(
              fontWeight: FontWeight.bold,
              color: isEmpty ? AppColor.hintColor : AppColor.primaryColor,
            )).expand(),
        Visibility(
          visible: enalble,
          child: Icon(
            Icons.arrow_drop_down,
            color: AppColor.primaryColor,
            size: AppDimens.iconMediumSize,
          ),
        ).paddingSymmetric(horizontal: 6.w)
      ],
    ).paddingSymmetric(vertical: 16.h);
  }
}
