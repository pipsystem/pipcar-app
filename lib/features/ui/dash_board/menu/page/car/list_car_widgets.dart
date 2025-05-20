// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_car_screen.dart';

class FormCarWidget {
  static Future<bool> showFormAdd(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    return await showDialog(
        barrierColor: AppColor.white,
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: true,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColor.white, // AppColor.white,
            titlePadding: EdgeInsets.zero,
            content: BlocProvider.value(
              value: context.read<CarListCubit>(), //blocCarList,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppDimens.borderSmall),
                              topRight: Radius.circular(AppDimens.borderSmall),
                            ),
                          ),
                          child: StyleLabel(
                            title: ListCarStrings.addCar.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: ThemeText.subtitle1.copyWith(
                                fontSize: 20.sp, color: AppColor.white),
                          ).paddingSymmetric(vertical: AppDimens.paddingSmall),
                        ),
                        Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.sizeOf(context).height * 0.4),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(AppDimens.borderSmall),
                                bottomRight:
                                    Radius.circular(AppDimens.borderSmall),
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    controller: context
                                        .read<CarListCubit>()
                                        .nameCarController,
                                    borderColor: AppColor.hintColor,
                                    hintText: ListCarStrings.nameCar,
                                    textStyle: ThemeText.caption,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return ListCarStrings.nameEmpty;
                                      }
                                      return null;
                                    },
                                    prefixIcon: ImageAppWidget(
                                      height: 10,
                                      path: Assets.images.icCars.keyName,
                                    ).paddingAll(AppDimens.paddingMedium),
                                  ).paddingBottom(AppDimens.paddingMedium),
                                  TextFieldWidget(
                                    controller: context
                                        .read<CarListCubit>()
                                        .plateCarController,
                                    borderColor: AppColor.hintColor,
                                    hintText: ListCarStrings.plate,
                                    textStyle: ThemeText.caption,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return ListCarStrings.plateEmpty;
                                      }
                                      return null;
                                    },
                                    prefixIcon: const Icon(
                                        Icons.confirmation_num_outlined,
                                        color: AppColor.primaryColor),
                                  ).paddingBottom(AppDimens.paddingMedium),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.hintColor),
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.borderSmall)),
                                    child:
                                        BlocBuilder<CarListCubit, CarListState>(
                                      builder: (context, state) {
                                        return DropdownButton<CarTypeEntity>(
                                          value: state.selectedCarTypeAdd,
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColor.primaryColor,
                                          ),
                                          elevation: 0,
                                          underline: const SizedBox(),
                                          dropdownColor:
                                              const Color(0xFFF5F9FF),
                                          borderRadius: BorderRadius.circular(
                                              AppDimens.borderSmall),
                                          onChanged: (CarTypeEntity? value) =>
                                              context
                                                  .read<CarListCubit>()
                                                  .onSelectedCarType(value!),
                                          isExpanded: true,
                                          items: AppConstant.listCarType.map<
                                                  DropdownMenuItem<
                                                      CarTypeEntity>>(
                                              (CarTypeEntity value) {
                                            return DropdownMenuItem<
                                                CarTypeEntity>(
                                              value: value,
                                              child: ItemDropDownCarType(
                                                  carType: value),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ).paddingSymmetric(
                                            horizontal:
                                                AppDimens.paddingVerySmall),
                                  )
                                ],
                              ).paddingAll(AppDimens.paddingMedium),
                            )),
                      ],
                    ).paddingBottom(AppDimens.paddingMedium),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButtonWidget(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            context.router.pop(true);
                            context.read<CarListCubit>().addCar();
                          }
                        },
                        title: translate("add"),
                        titleColor: AppColor.white,
                        buttonColor: AppColor.primaryColor,
                      ).expand(),
                      AppDimens.sizedBoxWidth10,
                      TextButtonWidget(
                        onPressed: () => context.router.pop(false),
                        title: translate("no"),
                        buttonColor: AppColor.borderCard,
                        titleColor: AppColor.primaryColor,
                        borderColor: AppColor.borderCard,
                      ).expand(),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ItemDropDownCarType extends StatelessWidget {
  final CarTypeEntity carType;
  const ItemDropDownCarType({super.key, required this.carType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageAppWidget(path: carType.image, width: AppDimens.iconLargeSize)
            .paddingRight(AppDimens.paddingMedium),
        StyleLabel(title: carType.name)
      ],
    );
  }
}
