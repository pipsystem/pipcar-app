import 'package:json_annotation/json_annotation.dart';

import 'package:pipcar/features/data/models/models.dart';

part 'supplier_complete_tickets.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierCompleteTicketsResponse {
  final List<SupplierTicketResponse>? supplierCompleteList;
  final Map<String, dynamic>? metaData;
  SupplierCompleteTicketsResponse({
    this.supplierCompleteList,
    this.metaData,
  });
  factory SupplierCompleteTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierCompleteTicketsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierCompleteTicketsResponseToJson(this);
}
