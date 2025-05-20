import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/features/domain/enterties/car_entity.dart';

import '../models/car/car_response.dart';

class CarMapper {
  static List<CarEntity> fromListCarResponse(List<CarResponse> response) {
    return response
        .map((e) => CarEntity(
            id: e.carId ?? "",
            agencyId: e.agencyId ?? "",
            carPlates: e.plates ?? "",
            carTypeName: e.carTypeId == null
                ? "Xe 5 chỗ"
                : AppConstant.listCarType
                    .firstWhere((element) => element.id == e.carTypeId!.toInt())
                    .name,
            carName: e.name ?? "",
            carLat: e.lat ?? "",
            carLong: e.long ?? "",
            timeUpdate: e.updatedGpsTime ??
                '00:00 29/02/2023')) //e.updatedGpsTime ?? ""))
        .toList();
  }

  static List<CarEntity> fromCarUnderliveredResponse(List<CarResponse> response) {
    return response.map((e) => 
      CarEntity(
        id: e.carId ?? "",
        agencyId: e.agencyId ?? "",
        carName: e.name ?? "",
        carTypeName: e.type ?? "",
        carLat: e.lat ?? "",
        carLong: e.long ?? "",
        carPlates: e.plates ?? "",
        timeUpdate: e.updatedGpsTime ?? '00:00 29/02/2023',
      )
    ).toList();
  }
}
