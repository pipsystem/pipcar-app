import 'package:json_annotation/json_annotation.dart';

import 'package:pipcar/features/data/models/models.dart';

part 'supplier_tickets_apply_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierTicketsApplyResponse {
  final List<SupplierTicketResponse>? supplierApplyList;
  final Map<String, dynamic>? metaData;
  SupplierTicketsApplyResponse({
    this.supplierApplyList,
    this.metaData,
  });
  factory SupplierTicketsApplyResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierTicketsApplyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierTicketsApplyResponseToJson(this);
}
