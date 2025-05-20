import 'package:json_annotation/json_annotation.dart';

part 'transaction_details_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TransactionDetailsResponse {
  final String? transactionCoinId;
  final int? amount;
  final int? type;
  final String? description;
  final int? newBalance;
  final String? updateTime;
  final TicketInforResponse? ticketInfo;

  TransactionDetailsResponse(
      {required this.transactionCoinId,
      required this.amount,
      required this.type,
      required this.description,
      required this.newBalance,
      required this.updateTime,
      required this.ticketInfo});

  factory TransactionDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketInforResponse {
  final String? ticketId;
  final String? carTypeName;
  final String? agencyId;
  final String? description;
  final String? supplierId;
  final int? coin;
  final String? dropoffProvince;
  final String? dropoffDistrict;
  final String? dropoffTime;
  final bool? isNavigate;
  final String? createdAt;
  final String? updatedAt;
  final String? pickupTime;
  final String? pickupProvinceName;
  final String? pickupDistrictName;
  final String? statusName;
  final int? status;

  TicketInforResponse(
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
  factory TicketInforResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketInforResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketInforResponseToJson(this);
}
