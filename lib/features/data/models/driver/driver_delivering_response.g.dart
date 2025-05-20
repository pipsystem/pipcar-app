// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_delivering_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDeliveringResponse _$ListDeliveringResponseFromJson(
        Map<String, dynamic> json) =>
    ListDeliveringResponse(
      driverList: (json['driver_list'] as List<dynamic>?)
          ?.map((e) =>
              DriverDeliveringResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListDeliveringResponseToJson(
        ListDeliveringResponse instance) =>
    <String, dynamic>{
      'driver_list': instance.driverList,
    };

DriverDeliveringResponse _$DriverDeliveringResponseFromJson(
        Map<String, dynamic> json) =>
    DriverDeliveringResponse(
      agencyId: json['agency_id'] as String?,
      driverPhone: json['driver_phone'] as String?,
      driverName: json['driver_name'] as String?,
      carName: json['car_name'] as String?,
      carPlate: json['car_plate'] as String?,
      isDriving: json['is_driving'] as bool?,
    );

Map<String, dynamic> _$DriverDeliveringResponseToJson(
        DriverDeliveringResponse instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'driver_phone': instance.driverPhone,
      'driver_name': instance.driverName,
      'car_name': instance.carName,
      'car_plate': instance.carPlate,
      'is_driving': instance.isDriving,
    };
