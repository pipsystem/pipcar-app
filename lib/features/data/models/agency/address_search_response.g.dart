// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressSearchResponse _$AddressSearchResponseFromJson(
        Map<String, dynamic> json) =>
    AddressSearchResponse(
      id: json['id'] as String?,
      addressName: json['address_name'] as String?,
      addressNameIndex: json['address_name_index'] as String?,
      provinceId: json['province_id'] as String?,
    );

Map<String, dynamic> _$AddressSearchResponseToJson(
        AddressSearchResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address_name': instance.addressName,
      'address_name_index': instance.addressNameIndex,
      'province_id': instance.provinceId,
    };
