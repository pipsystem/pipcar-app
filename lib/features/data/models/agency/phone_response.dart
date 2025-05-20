// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'phone_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PhoneResponse {
  final String? phone;
  final String? agencyName;
  final String? carLat;
  final String? carLong;
  final String? updatedGpsTime;
  PhoneResponse({
    this.phone,
    this.agencyName,
    this.carLat,
    this.carLong,
    this.updatedGpsTime,
  });

  factory PhoneResponse.fromJson(Map<String, dynamic> json) => _$PhoneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneResponseToJson(this);
}
