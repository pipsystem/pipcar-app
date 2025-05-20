// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'province_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProvinceResponse {
  final String? id;
  final String? name;
  final String? provinceId;
  final int? status;
  final int? priority;
  ProvinceResponse({
    this.id,
    this.name,
    this.provinceId,
    this.status,
    this.priority,
  });

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) => _$ProvinceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceResponseToJson(this);
}
