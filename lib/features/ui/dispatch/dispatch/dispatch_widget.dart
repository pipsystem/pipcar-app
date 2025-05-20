// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
part of 'dispatch_screen.dart';

class CurrentTicketBlock extends StatelessWidget {
  final InforDriverDispatchEntity? infor;
  const CurrentTicketBlock({
    Key? key,
    this.infor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFormView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CardViewBlue(
                title: 'Lịch đang đón khách...',
                prefixIcon: Icon(Icons.location_on_outlined,
                    color: AppColor.primaryColor, size: 15)),
            SizedBox(width: 20.w),
            Visibility(
                visible: infor?.ticketId != null,
                child: CardViewBlue(
                    title: infor?.pickUpTime ?? '',
                    prefixIcon: const Icon(Icons.access_time_rounded,
                        color: AppColor.primaryColor, size: 15))),
          ],
        ),
        AppDimens.sizedBoxHeight10,
        StyleLabel(
          title: infor?.desciptionCurrentTicket ?? "Chưa có lịch",
          maxLines: 100,
          style: ThemeText.caption.copyWith(fontWeight: FontWeight.w500),
        )
      ],
    ).paddingAll(AppDimens.paddingVerySmall));
  }
}

class InforCar extends StatelessWidget {
  final String name;
  final int carTypeId;
  final String plates;
  const InforCar({
    Key? key,
    required this.name,
    required this.carTypeId,
    required this.plates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var carType = '5';
    switch (carTypeId) {
      case 1:
        carType = '5';
        break;
      default:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            StyleLabel(
              title: name,
              style: ThemeText.note.copyWith(height: 0),
            ),
            const Icon(Icons.person, color: AppColor.primaryColor, size: 15),
            StyleLabel(
              title: carType,
              style: ThemeText.note.copyWith(height: 0),
            ),
          ],
        ),
        StyleLabel(
          title: plates,
          style: ThemeText.body2.copyWith(height: 1.5),
        ),
      ],
    ).paddingSymmetric(vertical: 10.h);
  }
}

class ListServiceDispatch extends StatelessWidget {
  final DriverDeleveringEntity driver;
  const ListServiceDispatch({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemDispatch(
                onPress: () {},
                title: "Thống kê",
                iconPath: Assets.icons.iconStatistical.keyName),
            ItemDispatch(
                onPress: () => context
                            .read<DispatchCubit>()
                            .state
                            .driverInfor !=
                        null
                    ? context.router.push(SystemSchedulePageRoute(
                        driver: driver.copyWith(
                            carTypeId: context
                                .read<DispatchCubit>()
                                .state
                                .driverInfor!
                                .carTypeId)))
                    : AppUtils.showToast(
                        "Get details driver delivering failed, please try again"),
                title: "Lịch mới",
                iconPath: Assets.icons.iconNewSchedule.keyName),
            ItemDispatch(
                onPress: () =>
                    context.router.push(MySchedulePageRoute(driver: driver)),
                title: "Lịch của xe",
                iconPath: Assets.images.iconCarHorizontal.keyName),
          ],
        ),
        SizedBox(height: 32.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemDispatch(
                onPress: () {},
                title: "Chấm công",
                iconPath: Assets.icons.iconTimeKeeping.keyName),
            ItemDispatch(
                onPress: () {},
                title: "Tính lương",
                iconPath: Assets.icons.iconWallet.keyName),
            SizedBox(width: (1.sw - 2 * AppDimens.paddingHorizontalApp) / 4)
          ],
        )
      ],
    ).paddingSymmetric(vertical: 17.h, horizontal: 20.w);
  }
}

class ItemDispatch extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final String iconPath;
  const ItemDispatch({
    Key? key,
    required this.onPress,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        width: (1.sw - 2 * AppDimens.paddingHorizontalApp) / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageAppWidget(
              path: iconPath,
              width: 25.w,
              color: AppColor.primaryColor,
            ).paddingBottom(AppDimens.paddingSmall),
            StyleLabel(
                title: title,
                style: ThemeText.caption.copyWith(fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
