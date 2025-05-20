// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarResponse _$CarResponseFromJson(Map<String, dynamic> json) => CarResponse(
      carId: json['car_id'] as String?,
      agencyId: json['agency_id'] as String?,
      plates: json['plates'] as String?,
      type: json['type'] as String?,
      carTypeId: json['car_type_id'] as int?,
      name: json['name'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      updatedGpsTime: json['updated_gps_time'] as String?,
    );

Map<String, dynamic> _$CarResponseToJson(CarResponse instance) =>
    <String, dynamic>{
      'car_id': instance.carId,
      'agency_id': instance.agencyId,
      'plates': instance.plates,
      'type': instance.type,
      'car_type_id': instance.carTypeId,
      'name': instance.name,
      'lat': instance.lat,
      'long': instance.long,
      'updated_gps_time': instance.updatedGpsTime,
    };
