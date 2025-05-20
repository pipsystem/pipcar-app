// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencySearchResponse _$AgencySearchResponseFromJson(
        Map<String, dynamic> json) =>
    AgencySearchResponse(
      rank: json['rank'] as int?,
      carName: json['car_name'] as String?,
      carPlates: json['car_plates'] as String?,
      agencyId: json['agency_id'] as String?,
      carId: json['car_id'] as String?,
      carLat: json['car_lat'] as String?,
      carLong: json['car_long'] as String?,
      avatar: json['avatar'] as String?,
      updatedGpsTime: json['updated_gps_time'] as String?,
      distance1: json['distance1'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AgencySearchResponseToJson(
        AgencySearchResponse instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'car_name': instance.carName,
      'car_plates': instance.carPlates,
      'agency_id': instance.agencyId,
      'car_id': instance.carId,
      'car_lat': instance.carLat,
      'car_long': instance.carLong,
      'avatar': instance.avatar,
      'updated_gps_time': instance.updatedGpsTime,
      'distance1': instance.distance1,
      'distance': instance.distance,
    };
