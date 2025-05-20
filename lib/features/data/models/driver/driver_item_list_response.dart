// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'car_drive_response.dart';

part 'driver_item_list_response.g.dart';

@JsonSerializable()
class DriverItemListResponse {
  final String? agency_id;
  final String? driver_id;
  final String? phone;
  final String? name;
  final bool? isCurrentDriver;
  final String? agency_code;
  final CarDriveResponse? car_info;
  DriverItemListResponse({
    this.agency_id,
    this.driver_id,
    this.phone,
    this.name,
    this.isCurrentDriver,
    this.agency_code,
    this.car_info,
  });

  factory DriverItemListResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverItemListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverItemListResponseToJson(this);
}
