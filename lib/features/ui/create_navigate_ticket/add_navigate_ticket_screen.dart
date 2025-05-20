// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/utils/utils_src.dart';

import '../../../../../common/di/di.dart';
import '../../../../../common/themes/themes.dart';
import '../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import 'cubit/add_navigate_ticket_cubit.dart';

@RoutePage()
class AddNavigatePageProvider extends StatelessWidget {
  final String supplierId;
  final int? carTypeId;
  const AddNavigatePageProvider(
      {Key? key, required this.supplierId, this.carTypeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AddNavigateTicketCubit>(),
      child: AddNavigateScreen(
        supplierId: supplierId,
      ),
    );
  }
}

class AddNavigateScreen extends StatefulWidget {
  final String supplierId;
  final int? carTypeId;
  const AddNavigateScreen({
    Key? key,
    required this.supplierId,
    this.carTypeId,
  }) : super(key: key);

  @override
  State<AddNavigateScreen> createState() => _AddNavigateScreenState();
}

class _AddNavigateScreenState extends State<AddNavigateScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: "Tạo lịch điều hướng", titleStyle: ThemeText.appBar),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SingleChildScrollView(
              child: BlocConsumer<AddNavigateTicketCubit, AddNavigateState>(
                listener: (context, state) {
                  if (state.status ==
                      AddNavigateStatus.createTicketSuccessful) {
                    context.router
                        .pop(AddNavigateStatus.createTicketSuccessful);
                    getIt.get<SnackbarBloc>().showSnackbar(
                        translationKey: "Tạo lịch thành công",
                        type: SnackBarType.success);
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildContentSchedule(context),
                      _buildAddress(context),
                      _buildPickUpTime(context),
                      _buildAddress(context, isPickUp: false),
                      _buildDropOffTime(context),
                    ],
                  );
                },
              ),
            ).expand(),
            TextButtonWidget(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (formKey.currentState!.validate()) {
                  context.read<AddNavigateTicketCubit>().createTicketNavigate(
                      supplierId: widget.supplierId,
                      carTypeId: widget.carTypeId);
                }
              },
              title: "Tạo lịch",
              titleColor: AppColor.white,
              buttonColor: AppColor.primaryColor,
            )
          ],
        ).paddingSymmetric(
            vertical: AppDimens.paddingVerticalApp,
            horizontal: AppDimens.paddingHorizontalApp),
      ),
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
          controller: context.read<AddNavigateTicketCubit>().contentController,
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

  Widget _buildAddress(BuildContext context, {bool isPickUp = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: isPickUp ? "Chọn khu vực đón" : "Chọn khu vực đến",
          style: ThemeText.body2.copyWith(fontWeight: FontType.bold),
        ).paddingBottom(AppDimens.paddingVerySmall),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.borderCard, width: 0.5),
              borderRadius: BorderRadius.circular(AppDimens.borderSmall)),
          child: BlocBuilder<AddNavigateTicketCubit, AddNavigateState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHorizontalText(
                    icon: Icons.location_city,
                    title: isPickUp
                        ? (state.provincePick == null
                            ? "Tỉnh thành đón"
                            : "${state.provincePick?.name} (Tỉnh thành đón)")
                        : (state.provinceDrop == null
                            ? "Tỉnh thành đến"
                            : "${state.provinceDrop?.name} (Tỉnh thành đến)"),
                    isEmpty: state.provincePick == null,
                  ).onTap(() => context.showBottomSheet(
                        title: isPickUp ? "Tỉnh thành đón" : "Tỉnh thành đến",
                        height: 300.h,
                        child: ListView.builder(
                            itemCount: state.provinces.length,
                            itemBuilder: (_, index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StyleLabel(
                                      textAlign: TextAlign.center,
                                      title: state.provinces[index].name,
                                    ).paddingSymmetric(vertical: 5.h),
                                  ],
                                ).onTap(() {
                                  context
                                      .read<AddNavigateTicketCubit>()
                                      .selectProvince(state.provinces[index],
                                          isPick: isPickUp);
                                  context.pop();
                                })).expand(),
                      )),
                  const Divider(
                      color: AppColor.grey,
                      height: 0,
                      endIndent: 20,
                      indent: 20),
                  _buildHorizontalText(
                    icon: Icons.location_city,
                    title: isPickUp
                        ? (state.districtPick == null
                            ? "Quận huyện đón"
                            : "${state.districtPick?.name} (Quận huyện đón)")
                        : (state.districtDrop == null
                            ? "Quận huyện đến"
                            : "${state.districtDrop?.name} (Quận huyện đến)"),
                    isEmpty: isPickUp
                        ? state.districtPick == null
                        : state.districtDrop == null,
                  ).onTap(() => (isPickUp
                              ? state.provincePick
                              : state.provinceDrop) !=
                          null
                      ? context.showBottomSheet(
                          title: isPickUp ? "Quận huyện đón" : "Quận huyện đến",
                          height: 300.h,
                          child: ListView.builder(
                              itemCount: isPickUp
                                  ? state.districtsPickList.length
                                  : state.districtsDropList.length,
                              itemBuilder: (_, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StyleLabel(
                                        textAlign: TextAlign.center,
                                        title: isPickUp
                                            ? state
                                                .districtsPickList[index].name
                                            : state
                                                .districtsDropList[index].name,
                                      ).paddingSymmetric(vertical: 5.h),
                                    ],
                                  ).onTap(() {
                                    context
                                        .read<AddNavigateTicketCubit>()
                                        .selectDistrict(
                                            isPickUp
                                                ? state.districtsPickList[index]
                                                : state
                                                    .districtsDropList[index],
                                            isPick: isPickUp);
                                    context.pop();
                                  })).expand(),
                        )
                      : AppUtils.showToast(isPickUp
                          ? "Vui lòng chọn tỉnh thành đón"
                          : "Vui lòng chọn tỉnh thành đến"))
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
        controller: context.read<AddNavigateTicketCubit>().pickUpTimeController,
        onConfirm: (date) {
          context.read<AddNavigateTicketCubit>().selectPickUpTime(date);
        });
  }

  Widget _buildDropOffTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleLabel(
          title: "Thời gian đến",
          style: ThemeText.body2,
        ).paddingBottom(6.h),
        TextFieldWidget(
          onTap: () {
            if (context
                .read<AddNavigateTicketCubit>()
                .pickUpTimeController
                .text
                .isEmpty) {
              AppUtils.showToast("Vui lòng chọn thời gian đón trước");
              return;
            }
            DateTime now = DateTime.now();
            DateTime minTime = DateFormat("HH:mm dd/MM/yyyy").parse(context
                .read<AddNavigateTicketCubit>()
                .pickUpTimeController
                .text);
            DateTime maxTime = now.add(const Duration(days: 30));
            DatePicker.showDateTimePicker(
              context,
              showTitleActions: true,
              minTime: minTime,
              maxTime: maxTime,
              onConfirm: (date) {
                context.read<AddNavigateTicketCubit>().selectDropOffTime(date);
              },
              currentTime: minTime,
              locale: LocaleType.vi,
            );
          },
          validate: (value) {
            if (value == null || value.isEmpty) {
              return "Không được để trống thời gian đến";
            }
            return null;
          },
          controller:
              context.read<AddNavigateTicketCubit>().dropOffTimeController,
          borderColor: AppColor.borderCard,
          hintText: "Chọn thời gian đến",
          hintStyle: ThemeText.note.copyWith(color: AppColor.hintColor),
          textStyle:
              ThemeText.style12Regular.copyWith(fontWeight: FontType.regular),
          readOnly: true,
          prefixIcon: Icon(
            Icons.access_time_rounded,
            size: AppDimens.iconMediumSize,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    ).paddingBottom(10.h);
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
            Icons.keyboard_arrow_down,
            color: AppColor.primaryColor,
            size: AppDimens.iconMediumSize,
          ),
        ).paddingSymmetric(horizontal: 6.w)
      ],
    ).paddingSymmetric(vertical: 16.h);
  }
}
