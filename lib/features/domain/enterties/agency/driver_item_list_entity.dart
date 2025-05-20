class DriverItemListEntity {
  final String agencyId;
  final String driverId;
  final String phone;
  final String name;
  final CarInfor? carInfor;
  final bool isCurrentdriver;
  final String? agencyCode;
  DriverItemListEntity({
    required this.agencyId,
    required this.driverId,
    required this.phone,
    required this.name,
    this.carInfor,
    required this.isCurrentdriver,
    this.agencyCode
  });
}

class CarInfor {
  final String carId;
  final String plates;
  final String type;
  final String name;
  CarInfor({
    required this.carId,
    required this.plates,
    required this.type,
    required this.name,
  });
}
