// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomersResponse _$CustomersResponseFromJson(Map<String, dynamic> json) =>
    CustomersResponse(
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      totalCompletedTicket: json['total_completed_ticket'] as int?,
    );

Map<String, dynamic> _$CustomersResponseToJson(CustomersResponse instance) =>
    <String, dynamic>{
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'total_completed_ticket': instance.totalCompletedTicket,
    };
