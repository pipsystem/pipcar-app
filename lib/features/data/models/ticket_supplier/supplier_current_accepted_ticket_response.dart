
import 'package:json_annotation/json_annotation.dart';

part 'supplier_current_accepted_ticket_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierCurentAcceptedTicketsResponse {
  String? currentTicketId;
  SupplierCurentAcceptedTicketsResponse({
    this.currentTicketId
  });
  factory SupplierCurentAcceptedTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierCurentAcceptedTicketsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierCurentAcceptedTicketsResponseToJson(this);
}
