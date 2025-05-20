// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_infor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyInforResponse _$AgencyInforResponseFromJson(Map<String, dynamic> json) =>
    AgencyInforResponse(
      agencyId: json['agency_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      isTransportation: json['is_transportation'] as bool?,
      isDriver: json['is_driver'] as bool?,
      coin: json['coin'] as int?,
      point: json['point'] as int?,
      agencyType: json['agency_type'] as String?,
      carTypeId: json['car_type_id'] as int?,
    );

Map<String, dynamic> _$AgencyInforResponseToJson(
        AgencyInforResponse instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'name': instance.name,
      'phone': instance.phone,
      'is_transportation': instance.isTransportation,
      'is_driver': instance.isDriver,
      'coin': instance.coin,
      'point': instance.point,
      'agency_type': instance.agencyType,
      'car_type_id': instance.carTypeId,
    };
