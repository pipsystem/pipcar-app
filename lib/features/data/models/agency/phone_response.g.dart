// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneResponse _$PhoneResponseFromJson(Map<String, dynamic> json) =>
    PhoneResponse(
      phone: json['phone'] as String?,
      agencyName: json['agency_name'] as String?,
      carLat: json['car_lat'] as String?,
      carLong: json['car_long'] as String?,
      updatedGpsTime: json['updated_gps_time'] as String?,
    );

Map<String, dynamic> _$PhoneResponseToJson(PhoneResponse instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'agency_name': instance.agencyName,
      'car_lat': instance.carLat,
      'car_long': instance.carLong,
      'updated_gps_time': instance.updatedGpsTime,
    };
