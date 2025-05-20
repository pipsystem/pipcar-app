// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'driver_item_list_response.dart';

part 'driver_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DriverListResponse {
  final List<DriverItemListResponse> driverList;

  DriverListResponse({
    required this.driverList,
  });

  factory DriverListResponse.fromJson(Map<String, dynamic> json) => _$DriverListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverListResponseToJson(this);
}
