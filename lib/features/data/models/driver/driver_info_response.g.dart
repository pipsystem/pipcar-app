// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverInfoResponse _$DriverInfoResponseFromJson(Map<String, dynamic> json) =>
    DriverInfoResponse(
      driverPhone: json['driver_phone'] as String?,
      driverName: json['driver_name'] as String?,
      carPlate: json['car_plate'] as String?,
      carName: json['car_name'] as String?,
      carTypeName: json['car_type_name'] as String?,
      agencyCode: json['agency_code'] as String?,
      agencyAvatar: json['agency_avatar'] as String?,
    );

Map<String, dynamic> _$DriverInfoResponseToJson(DriverInfoResponse instance) =>
    <String, dynamic>{
      'driver_phone': instance.driverPhone,
      'driver_name': instance.driverName,
      'car_plate': instance.carPlate,
      'car_name': instance.carName,
      'car_type_name': instance.carTypeName,
      'agency_code': instance.agencyCode,
      'agency_avatar': instance.agencyAvatar,
    };
