// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'supplier_ticket_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierTicketResponse {
  final String? ticketId;
  final String? carTypeName;
  final String? agencyId;
  final String? description;
  final String? supplierId;
  final int? coin;
  final String? createdAt;
  final String? updatedAt;
  // final List<dynamic> waitList;
  final String? pickupTime;
  final String? pickupProvinceName;
  final String? pickupDistrictName;
  final String? dropoffTime;
  final String? dropoffProvinceName;
  final String? dropoffDistrictName;
  final String? statusName;
  final String? ownerName;
  final String? ownerAvatar;
  final int? status;
  final bool? isNavigate;
  SupplierTicketResponse({
    this.ticketId,
    this.carTypeName,
    this.agencyId,
    this.description,
    this.supplierId,
    this.coin,
    this.createdAt,
    this.updatedAt,
    this.pickupTime,
    this.pickupProvinceName,
    this.pickupDistrictName,
    this.dropoffTime,
    this.dropoffProvinceName,
    this.dropoffDistrictName,
    this.statusName,
    this.ownerName,
    this.ownerAvatar,
    this.status,
    this.isNavigate,
  });
  factory SupplierTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierTicketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierTicketResponseToJson(this);
}
