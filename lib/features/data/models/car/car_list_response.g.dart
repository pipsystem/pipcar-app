// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarListResponse _$CarListResponseFromJson(Map<String, dynamic> json) =>
    CarListResponse(
      carList: (json['car_list'] as List<dynamic>)
          .map((e) => CarResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarListResponseToJson(CarListResponse instance) =>
    <String, dynamic>{
      'car_list': instance.carList,
    };
