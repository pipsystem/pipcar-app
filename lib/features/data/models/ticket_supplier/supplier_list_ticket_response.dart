// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:pipcar/features/data/models/models.dart';

part 'supplier_list_ticket_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierListTicketResponse {
  final List<SupplierTicketResponse>? supplierNewList;
  final Map<String, dynamic>? metaData;
  SupplierListTicketResponse({
    this.supplierNewList,
    this.metaData,
  });
  factory SupplierListTicketResponse.fromJson(Map<String, dynamic> json) => _$SupplierListTicketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierListTicketResponseToJson(this);
}
