import 'package:json_annotation/json_annotation.dart';

part 'driver_location_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)

class DriverLocationResponse {
  final String? lat;
  final String? long;
  final double? updatedGpsTime;
  final double? distance;

  DriverLocationResponse(this.updatedGpsTime, this.distance, {this.lat, this.long});

  factory DriverLocationResponse.fromJson(Map<String, dynamic> json) => _$DriverLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverLocationResponseToJson(this);
}