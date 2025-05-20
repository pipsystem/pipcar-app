// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictResponse _$DistrictResponseFromJson(Map<String, dynamic> json) =>
    DistrictResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      provinceId: json['province_id'] as String?,
      centerLat: (json['center_lat'] as num?)?.toDouble(),
      centerLong: (json['center_long'] as num?)?.toDouble(),
      status: json['status'] as int?,
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$DistrictResponseToJson(DistrictResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province_id': instance.provinceId,
      'center_lat': instance.centerLat,
      'center_long': instance.centerLong,
      'status': instance.status,
      'priority': instance.priority,
    };
