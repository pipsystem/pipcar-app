// ignore_for_file: public_member_api_docs, sort_constructors_first
class DistrictEntity {
  final String id;
  final String name;
  final String provinceId;
  final double centerLat;
  final double centerLong;
  final int status;
  final int priority;
  DistrictEntity({
    required this.id,
    required this.name,
    required this.provinceId,
    required this.centerLat,
    required this.centerLong,
    required this.status,
    required this.priority,
  });
}

class ProvinceEntity {
  final String id;
  final String name;
  final String provinceId;
  final int status;
  final int priority;
  ProvinceEntity({
    required this.id,
    required this.name,
    required this.provinceId,
    required this.status,
    required this.priority,
  });
}
