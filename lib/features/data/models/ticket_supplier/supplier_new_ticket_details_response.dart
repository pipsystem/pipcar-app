// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:pipcar/features/data/models/ticket_owner/customer_response.dart';
import 'package:pipcar/features/data/models/ticket_supplier/current_agency_infor_response.dart';
import '../ticket_owner/supplier_response.dart';
import 'agency_infor_response.dart';
import 'supplier_ticket_response.dart';

part 'supplier_new_ticket_details_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierNewTicketDetailsResponse {
  final SupplierTicketResponse? ticketInfo;
  final CurrentAgencyInforResponse? currentAgencyInfo;
  final List<SupplierResponse>? listSupplier;
  final AgencyInforResponse? agencyInfo;
  final CustomerResponse? customerInfo;
  SupplierNewTicketDetailsResponse({
    this.ticketInfo,
    this.currentAgencyInfo,
    this.listSupplier,
    required this.agencyInfo,
    required this.customerInfo,
  });
  factory SupplierNewTicketDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierNewTicketDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierNewTicketDetailsResponseToJson(this);
}
