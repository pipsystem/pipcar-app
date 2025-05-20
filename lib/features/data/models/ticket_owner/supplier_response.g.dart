// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierResponse _$SupplierResponseFromJson(Map<String, dynamic> json) =>
    SupplierResponse(
      supplierId: json['supplier_id'] as String?,
      supplierName: json['supplier_name'] as String?,
      supplierPhone: json['supplier_phone'] as String?,
      carTypeName: json['car_type_name'] as String?,
      carName: json['car_name'] as String?,
      carPlate: json['car_plate'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      updatedGpsTime: json['updated_gps_time'] as String?,
      distance: json['distance'] as String?,
    );

Map<String, dynamic> _$SupplierResponseToJson(SupplierResponse instance) =>
    <String, dynamic>{
      'supplier_id': instance.supplierId,
      'supplier_name': instance.supplierName,
      'supplier_phone': instance.supplierPhone,
      'car_type_name': instance.carTypeName,
      'car_name': instance.carName,
      'car_plate': instance.carPlate,
      'lat': instance.lat,
      'long': instance.long,
      'updated_gps_time': instance.updatedGpsTime,
      'distance': instance.distance,
    };
