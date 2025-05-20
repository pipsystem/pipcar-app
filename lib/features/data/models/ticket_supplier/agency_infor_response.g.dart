// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_infor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyInforResponse _$AgencyInforResponseFromJson(Map<String, dynamic> json) =>
    AgencyInforResponse(
      agencyId: json['agency_id'] as String?,
      agencyPhone: json['agency_phone'] as String?,
      agencyName: json['agency_name'] as String?,
    );

Map<String, dynamic> _$AgencyInforResponseToJson(
        AgencyInforResponse instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'agency_phone': instance.agencyPhone,
      'agency_name': instance.agencyName,
    };
