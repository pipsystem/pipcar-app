// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'supplier_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupplierResponse {
  final String? supplierId;
  final String? supplierName;
  final String? supplierPhone;
  final String? carTypeName;
  final String? carName;
  final String? carPlate;
  final String? lat;
  final String? long;
  final String? updatedGpsTime;
  final String? distance;
  SupplierResponse(
      {this.supplierId,
      this.supplierName,
      this.supplierPhone,
      this.carTypeName,
      this.carName,
      this.carPlate,
      this.lat,
      this.long,
      this.updatedGpsTime,
      this.distance});

  factory SupplierResponse.fromJson(Map<String, dynamic> json) => _$SupplierResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierResponseToJson(this);
}
