// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'customer_response.dart';
import 'owner_ticket_response.dart';
import 'supplier_response.dart';

part 'ticket_details_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketDetailsResponse {
  final OwnerTicketResponse? ticketInfo;
  final List<SupplierResponse>? listSupplier;
  final CustomerResponse? customerInfo;
  TicketDetailsResponse({
    this.ticketInfo,
    this.listSupplier,
    this.customerInfo,
  });

  factory TicketDetailsResponse.fromJson(Map<String, dynamic> json) => _$TicketDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TicketDetailsResponseToJson(this);
}
