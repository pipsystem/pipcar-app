class TransactionDetailEntity {
  final String transactionId;
  final String ticketId;
  final int type;
  final int amount;
  final String updateTime;
  final int balance;
  final String description;
  final TicketInforEntity ticketInfor;

  TransactionDetailEntity(
      {required this.transactionId,
      required this.ticketId,
      required this.type,
      required this.amount,
      required this.updateTime,
      required this.balance,
      required this.ticketInfor,
      required this.description});
}

class TicketInforEntity {
  final String ticketId;
  final String carTypeName;
  final String agencyId;
  final String description;
  final String supplierId;
  final int coin;
  final String dropoffProvince;
  final String dropoffDistrict;
  final String dropoffTime;
  final bool isNavigate;
  final String createdAt;
  final String updatedAt;
  final String pickupTime;
  final String pickupProvinceName;
  final String pickupDistrictName;
  final String statusName;
  final int status;

  TicketInforEntity(
      {required this.ticketId,
      required this.carTypeName,
      required this.agencyId,
      required this.description,
      required this.supplierId,
      required this.coin,
      required this.dropoffProvince,
      required this.dropoffDistrict,
      required this.dropoffTime,
      required this.isNavigate,
      required this.createdAt,
      required this.updatedAt,
      required this.pickupTime,
      required this.pickupProvinceName,
      required this.pickupDistrictName,
      required this.statusName,
      required this.status});
}
