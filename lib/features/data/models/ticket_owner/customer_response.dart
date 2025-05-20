// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'customer_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CustomerResponse {
  final String? customerId;
  final String? customerPhone;
  final String? customerName;
  CustomerResponse({
    this.customerId,
    this.customerPhone,
    this.customerName,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}
