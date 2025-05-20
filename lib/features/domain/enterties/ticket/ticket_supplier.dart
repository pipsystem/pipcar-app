// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pipcar/common/utils/extension_utils.dart';

class TicketSupplierEntity {
  final String ticketId;
  final String carTypeName;
  final String agencyId;
  final String description;
  final String supplierId;
  final int coin;
  final String createdAt;
  final String updatedAt;
  // final List<dynamic> waitList;
  final String pickupTime;
  final String pickupProvinceName;
  final String pickupDistrictName;
  final String dropOffTime;
  final String dropOffProvinceName;
  final String dropOffDistrictName;
  final String statusName;
  final String ownerName;
  final String ownerAvatar;
  final int status;
  final bool isNavigate;
  TicketSupplierEntity({
    required this.ticketId,
    required this.carTypeName,
    required this.agencyId,
    required this.description,
    required this.supplierId,
    required this.coin,
    required this.createdAt,
    required this.updatedAt,
    required this.pickupTime,
    required this.pickupProvinceName,
    required this.pickupDistrictName,
    required this.dropOffTime,
    required this.dropOffProvinceName,
    required this.dropOffDistrictName,
    required this.statusName,
    required this.ownerName,
    required this.ownerAvatar,
    required this.status,
    required this.isNavigate,
  });
}

extension TextToSpeechTicket on TicketSupplierEntity {
  String speech() {
    int diff = pickupTime.calculateTimeDifferenceNumber();
    if (diff < 12 && diff != -1) {
      return "Xe $carTypeName, $description, Đón khách sau ${pickupTime.calculateTimeDifference()} nữa"
          .removeLinks();
    } else {
      return "Xe $carTypeName, $description, Đón khách lúc ${pickupTime.formatSpeechTimeCurrent()}"
          .removeLinks();
    }
  }
}
