// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_item_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverItemListResponse _$DriverItemListResponseFromJson(
        Map<String, dynamic> json) =>
    DriverItemListResponse(
      agency_id: json['agency_id'] as String?,
      driver_id: json['driver_id'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      isCurrentDriver: json['isCurrentDriver'] as bool?,
      agency_code: json['agency_code'] as String?,
      car_info: json['car_info'] == null
          ? null
          : CarDriveResponse.fromJson(json['car_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DriverItemListResponseToJson(
        DriverItemListResponse instance) =>
    <String, dynamic>{
      'agency_id': instance.agency_id,
      'driver_id': instance.driver_id,
      'phone': instance.phone,
      'name': instance.name,
      'isCurrentDriver': instance.isCurrentDriver,
      'agency_code': instance.agency_code,
      'car_info': instance.car_info,
    };
