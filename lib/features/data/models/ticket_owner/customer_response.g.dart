// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      customerId: json['customer_id'] as String?,
      customerPhone: json['customer_phone'] as String?,
      customerName: json['customer_name'] as String?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'customer_phone': instance.customerPhone,
      'customer_name': instance.customerName,
    };
