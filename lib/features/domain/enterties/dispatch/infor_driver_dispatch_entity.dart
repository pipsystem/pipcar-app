// ignore_for_file: public_member_api_docs, sort_constructors_first
class InforDriverDispatchEntity {
  final String agencyId;
  final String driverName;
  final String driverPhone;
  final String carPlate;
  final String carName;
  final String carTypeName;
  final int carTypeId;
  final int currentMonth;
  final String? ticketId;
  final String? desciptionCurrentTicket;
  final String? pickUpTime;
  InforDriverDispatchEntity({
    required this.agencyId,
    required this.driverName,
    required this.driverPhone,
    required this.carPlate,
    required this.carName,
    required this.carTypeName,
    required this.carTypeId,
    required this.currentMonth,
    this.ticketId,
    this.desciptionCurrentTicket,
    this.pickUpTime,
  });
}
