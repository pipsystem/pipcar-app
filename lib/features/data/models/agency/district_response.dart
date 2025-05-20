// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'district_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DistrictResponse {
  final String? id;
  final String? name;
  final String? provinceId;
  final double? centerLat;
  final double? centerLong;
  final int? status;
  final int? priority;
  DistrictResponse({
    this.id,
    this.name,
    this.provinceId,
    this.centerLat,
    this.centerLong,
    this.status,
    this.priority,
  });

  factory DistrictResponse.fromJson(Map<String, dynamic> json) => _$DistrictResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictResponseToJson(this);
}
