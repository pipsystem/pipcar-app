// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'owner_ticket_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OwnerTicketResponse {
  final String? ticketId;
  final String? carTypeName;
  final String? agencyId;
  final String? description;
  final String? supplierId;
  final int? coin;
  final String? pickupProvinceName;
  final String? pickupDistrictName;
  final String? createdAt;
  final String? updatedAt;
  final String? pickupTime;
  final String? statusName;
  final String? ownerName;
  final String? ownerAvatar;
  final int? waitCount;
  final int? status;
  OwnerTicketResponse({
    this.ticketId,
    this.carTypeName,
    this.agencyId,
    this.description,
    this.supplierId,
    this.coin,
    this.pickupProvinceName,
    this.pickupDistrictName,
    this.createdAt,
    this.updatedAt,
    this.pickupTime,
    this.statusName,
    this.ownerName,
    this.ownerAvatar,
    this.waitCount,
    this.status,
  });

  factory OwnerTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$OwnerTicketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerTicketResponseToJson(this);
}
