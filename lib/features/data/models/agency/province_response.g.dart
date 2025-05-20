// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceResponse _$ProvinceResponseFromJson(Map<String, dynamic> json) =>
    ProvinceResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      provinceId: json['province_id'] as String?,
      status: json['status'] as int?,
      priority: json['priority'] as int?,
    );

Map<String, dynamic> _$ProvinceResponseToJson(ProvinceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'province_id': instance.provinceId,
      'status': instance.status,
      'priority': instance.priority,
    };
