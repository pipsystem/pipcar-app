import 'package:json_annotation/json_annotation.dart';

part 'customers_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CustomersResponse {
  final String? customerName;
  final String? customerPhone;
  final int? totalCompletedTicket;
  CustomersResponse({
    this.customerName,
    this.customerPhone,
    this.totalCompletedTicket,
  });

  factory CustomersResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomersResponseToJson(this);
}
