// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_drive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarDriveResponse _$CarDriveResponseFromJson(Map<String, dynamic> json) =>
    CarDriveResponse(
      carId: json['car_id'] as String?,
      plates: json['plates'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CarDriveResponseToJson(CarDriveResponse instance) =>
    <String, dynamic>{
      'car_id': instance.carId,
      'plates': instance.plates,
      'type': instance.type,
      'name': instance.name,
    };
