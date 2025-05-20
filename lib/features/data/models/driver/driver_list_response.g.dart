// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverListResponse _$DriverListResponseFromJson(Map<String, dynamic> json) =>
    DriverListResponse(
      driverList: (json['driver_list'] as List<dynamic>)
          .map(
              (e) => DriverItemListResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DriverListResponseToJson(DriverListResponse instance) =>
    <String, dynamic>{
      'driver_list': instance.driverList,
    };
