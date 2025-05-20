import 'package:json_annotation/json_annotation.dart';

part 'driver_info_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DriverInfoResponse {
  final String? driverPhone;
  final String? driverName;
  final String? carPlate;
  final String? carName;
  final String? carTypeName;
  final String? agencyCode;
  final String? agencyAvatar;
  DriverInfoResponse({
    this.driverPhone,
    this.driverName,
    this.carPlate,
    this.carName,
    this.carTypeName,
    this.agencyCode,
    this.agencyAvatar
  });

  factory DriverInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverInfoResponseToJson(this);
}