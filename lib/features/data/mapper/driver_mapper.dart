import 'package:pipcar/features/data/models/driver/driver_info_response.dart';
import 'package:pipcar/features/data/models/driver/driver_list_response.dart';
import 'package:pipcar/features/domain/enterties/agency/driver_item_list_entity.dart';
import 'package:pipcar/features/domain/enterties/dispatch/driver_delivering_entity.dart';
import 'package:pipcar/features/domain/enterties/driver_info_entity.dart';

import '../models/driver/driver_delivering_response.dart';

class DriverMapper {
  static List<DriverItemListEntity> fromListDriverResponse(
      DriverListResponse response) {
    return response.driverList
        .map((e) => DriverItemListEntity(
              agencyId: e.agency_id ?? "",
              driverId: e.driver_id ?? "",
              phone: e.phone ?? "",
              name: e.name ?? "",
              carInfor: e.car_info != null
                  ? CarInfor(
                      carId: e.car_info?.carId ?? "",
                      plates: e.car_info?.plates ?? "",
                      type: e.car_info?.type ?? "",
                      name: e.car_info?.name ?? "",
                    )
                  : null,
              isCurrentdriver: e.isCurrentDriver ?? false,
              agencyCode: e.agency_code ?? "",
            ))
        .toList();
  }

  static List<DriverDeleveringEntity> converDriverDelivering(
      ListDeliveringResponse response) {
    return response.driverList != null
        ? response.driverList!
            .map((e) => DriverDeleveringEntity(
                agencyId: e.agencyId ?? '',
                driverPhone: e.driverPhone ?? '',
                driverName: e.driverName ?? '',
                carName: e.carName ?? '',
                carPlate: e.carPlate ?? '',
                carTypeId: 1,
                isDriving: e.isDriving ?? false))
            .toList()
        : [];
  }

  static DriverInfoEntity convertDriverInfo(DriverInfoResponse response){
    return DriverInfoEntity(
      name: response.driverName ?? '',
      phone: response.driverPhone ?? '',
      carPlate: response.carPlate ?? '',
      carName: response.carName ?? '',
      carTypeName: response.carTypeName ?? '',
      agencyCode: response.agencyCode ?? '',
      avatar: response.agencyAvatar ?? '',
    );
  }
}
