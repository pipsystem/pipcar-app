import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_search_infor_entity.dart';
import 'package:pipcar/features/domain/enterties/driver_location_entity.dart';

import '../../../common/configs/constants/app_dimens.dart';
import '../../../common/themes/themes.dart';
import '../../../features/domain/enterties/entities.dart';
import 'widgets.dart';

class ItemInforCarBase extends StatelessWidget {
  final CarDetailsBase car;
  final AgencySearchEntity? agency;
  final SupplierEntity? supplier;
  final AgencySearchInforEntity? agencySearchInfor;
  final String? phone;
  final String? carTypeName;
  final String? driverName;
  final String? distance;
  const ItemInforCarBase(
      {super.key, required this.car, this.agency, this.agencySearchInfor, this.carTypeName, this.driverName, this.phone, this.distance, this.supplier});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppDimens.borderSmall),
          boxShadow: [
            BoxShadow(color: AppColor.black.withOpacity(0.25), blurRadius: 6)
          ]),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 10.w,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimens.borderSmall),
                        bottomLeft: Radius.circular(AppDimens.borderSmall))),
              ).paddingRight(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHeaderInfor(car),
                  _buildInforDriver().expand()
                ],
              ).paddingTop(5).expand()
            ],
          ),
          // Align(alignment: AlignmentDirectional.bottomEnd, child: _buildButtonCall())
        ],
      ),
    ).paddingTop(AppDimens.appBarHeight + 50.h).paddingLeft(5.w);
  }

  Widget _buildHeaderInfor(CarDetailsBase car) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyleLabel(
          title: "Thông tin xe",
          style: ThemeText.mediumTextTicket.copyWith(fontSize: 13.sp, color: AppColor.dividerColor),
        ),
        StyleLabel(
          title: "Cập nhật vị trí: ${car.timeUpdate.formatTimeDifference()}",
          style: ThemeText.mediumTextTicket.copyWith(fontSize: 13.sp, color: AppColor.dividerColor),
        )
      ],
    ).paddingRight(AppDimens.paddingSmall);
  }

  Widget _buildInforDriver() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageAppWidget(
          path: agency == null ? Assets.images.defaultAvt.keyName : agency!.avatar != "" ? agency!.avatar : Assets.images.defaultAvt.keyName,
          width: 56.w,
        ).paddingRight(5.w).paddingBottom(18.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppDimens.sizedBoxHeight10,
            agencySearchInfor != null ? StyleLabel(
              title: driverName ?? agencySearchInfor!.agencyName,
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ):
            StyleLabel(
              title: carTypeName ?? car.carTypeName,
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ),
            agencySearchInfor != null ? StyleLabel(
              title: phone ?? agencySearchInfor!.phone,
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ) : supplier != null ? StyleLabel(
              title: phone ?? supplier!.supplierPhone,
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ) :
            StyleLabel(
              title: car.carPlates,
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ),
            StyleLabel(
              title: car.carName,
              style: ThemeText.caption.copyWith(
                color: AppColor.dividerColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp
              ),
              maxLines: 3,
            ),
            (agencySearchInfor != null || supplier != null) ? StyleLabel(
              title: car.carPlates,
              style: ThemeText.style12Regular.copyWith(
                  color: AppColor.dividerColor, fontWeight: FontWeight.w400,
                  fontSize: 12.sp),
              maxLines: 2,
            ) :
            StyleLabel(
              title: distance ?? "",
              style: ThemeText.style12Regular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.borderCard, fontWeight: FontWeight.w400),
            )
          ],
        ).expand(),
      ],
    ).paddingBottom(AppDimens.paddingSmall);
  }
}

class ItemInforCarBase2 extends StatelessWidget {
  final DriverLocationEntity driver;
  final String plate;
  final String phone;
  final String carTypeName;
  final String carName;
  final String distance;
  final String avatar;

  const ItemInforCarBase2({super.key, required this.driver, required this.plate, required this.phone, required this.carTypeName, required this.distance, required this.carName, required this.avatar});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppDimens.borderSmall),
          boxShadow: [
            BoxShadow(color: AppColor.black.withOpacity(0.25), blurRadius: 6)
          ]),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 10.w,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimens.borderSmall),
                        bottomLeft: Radius.circular(AppDimens.borderSmall))),
              ).paddingRight(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildHeaderInfor(driver),
                  _buildInforDriver().expand()
                ],
              ).paddingTop(5).expand()
            ],
          ),
          // Align(alignment: AlignmentDirectional.bottomEnd, child: _buildButtonCall())
        ],
      ),
    ).paddingTop(AppDimens.appBarHeight + 50.h).paddingLeft(5.w);
  }

  Widget _buildHeaderInfor(DriverLocationEntity driver) {
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final timeFormatter = DateFormat('HH:mm');
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(driver.updateTime.toInt());
    final formattedDate = dateFormatter.format(dateTime);
    final formattedTime = timeFormatter.format(dateTime);
    String updateTime = "$formattedTime $formattedDate";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyleLabel(
          title: "Thông tin xe",
          style: ThemeText.mediumTextTicket.copyWith(fontSize: 13.sp, color: AppColor.dividerColor),
        ),
        StyleLabel(
          title: "Cập nhật vị trí: ${updateTime.formatTimeDifference()}", // ${driver.updateTime.toString().formatTimeDifference()}
          style: ThemeText.mediumTextTicket.copyWith(fontSize: 13.sp, color: AppColor.dividerColor),
        )
      ],
    ).paddingRight(AppDimens.paddingSmall);
  }

  Widget _buildInforDriver() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageAppWidget(
          path: avatar != '' ? avatar : Assets.images.defaultAvt.keyName,
          width: 56.w,
          radius: AppDimens.borderMedium,
        ).paddingRight(5.w).paddingBottom(18.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppDimens.sizedBoxHeight10,
            StyleLabel(
              title: "Xe $carTypeName",
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ),
            StyleLabel(
              title: plate,
              style: ThemeText.body2.copyWith(fontSize: 16.sp),
            ),
            StyleLabel(
              title: carName,
              style: ThemeText.caption.copyWith(
                color: AppColor.dividerColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp
              ),
              maxLines: 3,
            ),
            StyleLabel(
              title: distance,
              style: ThemeText.style12Regular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.borderCard, fontWeight: FontWeight.w400),
            )
          ],
        ).expand(),
      ],
    ).paddingBottom(AppDimens.paddingSmall);
  }
}
