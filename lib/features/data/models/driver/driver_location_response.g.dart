// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverLocationResponse _$DriverLocationResponseFromJson(
        Map<String, dynamic> json) =>
    DriverLocationResponse(
      (json['updated_gps_time'] as num?)?.toDouble(),
      (json['distance'] as num?)?.toDouble(),
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );

Map<String, dynamic> _$DriverLocationResponseToJson(
        DriverLocationResponse instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'updated_gps_time': instance.updatedGpsTime,
      'distance': instance.distance,
    };
