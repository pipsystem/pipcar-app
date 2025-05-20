// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_agency_infor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAgencyInforResponse _$CurrentAgencyInforResponseFromJson(
        Map<String, dynamic> json) =>
    CurrentAgencyInforResponse(
      carName: json['car_name'] as String?,
      carPlate: json['car_plate'] as String?,
      coin: json['coin'] as int?,
    );

Map<String, dynamic> _$CurrentAgencyInforResponseToJson(
        CurrentAgencyInforResponse instance) =>
    <String, dynamic>{
      'car_name': instance.carName,
      'car_plate': instance.carPlate,
      'coin': instance.coin,
    };
