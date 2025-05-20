// ignore_for_file: public_member_api_docs, sort_constructors_first
class DriverDeleveringEntity {
  final String agencyId;
  final String driverPhone;
  final String driverName;
  final String carName;
  final String carPlate;
  final bool isDriving;
  final int carTypeId;
  DriverDeleveringEntity({
    required this.agencyId,
    required this.driverPhone,
    required this.driverName,
    required this.carName,
    required this.carPlate,
    required this.isDriving,
    required this.carTypeId,
  });

  DriverDeleveringEntity copyWith({
    String? agencyId,
    String? driverPhone,
    String? driverName,
    String? carName,
    String? carPlate,
    bool? isDriving,
    int? carTypeId,
  }) {
    return DriverDeleveringEntity(
      agencyId: agencyId ?? this.agencyId,
      driverPhone: driverPhone ?? this.driverPhone,
      driverName: driverName ?? this.driverName,
      carName: carName ?? this.carName,
      carPlate: carPlate ?? this.carPlate,
      isDriving: isDriving ?? this.isDriving,
      carTypeId: carTypeId ?? this.carTypeId,
    );
  }
}
