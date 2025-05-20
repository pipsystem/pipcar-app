class TicketOwnerProcessEntity {
  final String ticketId;
  final String carTypeName;
  final String agencyId;
  final String description;
  final String supplierId;
  final int coin;
  final String statusName;
  final int status;
  final String pickupProvinceName;
  final String pickupDistrictName;
  final String pickupTime;
  final String ownerName;
  final String ownerAvatar;
  TicketOwnerProcessEntity({
    required this.ticketId,
    required this.carTypeName,
    required this.agencyId,
    required this.description,
    required this.supplierId,
    required this.coin,
    required this.statusName,
    required this.status,
    required this.pickupProvinceName,
    required this.pickupDistrictName,
    required this.pickupTime,
    required this.ownerName,
    required this.ownerAvatar
  });
}