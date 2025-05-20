// ignore_for_file: public_member_api_docs, sort_constructors_first
class AgencySearchEntity extends CarDetailsBase {
  final int rank;
  final String agencyId;
  final String avatar;
  final String distance1;
  final double distance;

  AgencySearchEntity({
    required this.rank,
    required this.agencyId,
    required this.avatar,
    required this.distance1,
    required this.distance,
    required super.id,
    required super.carName,
    required super.carPlates,
    required super.carLat,
    required super.carLong,
    required super.timeUpdate,
    required super.carTypeName,
  });
}

class CarDetailsBase {
  final String id;
  final String carName;
  final String carTypeName;
  final String carPlates;
  final String carLat;
  final String carLong;
  final String timeUpdate;
  CarDetailsBase({
    required this.id,
    required this.carTypeName,
    required this.carName,
    required this.carPlates,
    required this.carLat,
    required this.carLong,
    required this.timeUpdate,
  });
}
