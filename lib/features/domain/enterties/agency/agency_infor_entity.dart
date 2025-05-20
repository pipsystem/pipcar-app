// ignore_for_file: public_member_api_docs, sort_constructors_first
class AgencyInforEntity {
  final String agencyId;
  final String name;
  final String phone;
  final bool isTransportation;
  final bool isDriver;
  final int coin;
  final int point;
  final String agencyType;
  final int carTypeId;

  AgencyInforEntity({
    required this.agencyId,
    required this.name,
    required this.phone,
    required this.isTransportation,
    required this.isDriver,
    required this.coin,
    required this.point,
    required this.agencyType,
    required this.carTypeId,
  });
}
