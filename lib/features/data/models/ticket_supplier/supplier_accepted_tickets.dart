import 'package:json_annotation/json_annotation.dart';

import 'package:pipcar/features/data/models/models.dart';

part 'supplier_accepted_tickets.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierAcceptedTicketsResponse {
  final List<SupplierTicketResponse>? supplierAcceptedList;
  final Map<String, dynamic>? metaData;
  SupplierAcceptedTicketsResponse({
    this.supplierAcceptedList,
    this.metaData,
  });
  factory SupplierAcceptedTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierAcceptedTicketsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierAcceptedTicketsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierDropOffTicketsResponse {
  final List<SupplierTicketResponse>? supplierDropOffList;
  final Map<String, dynamic>? metaData;
  SupplierDropOffTicketsResponse({
    this.supplierDropOffList,
    this.metaData,
  });
  factory SupplierDropOffTicketsResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplierDropOffTicketsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierDropOffTicketsResponseToJson(this);
}
