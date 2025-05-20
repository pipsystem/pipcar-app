// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_accepted_tickets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierAcceptedTicketsResponse _$SupplierAcceptedTicketsResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierAcceptedTicketsResponse(
      supplierAcceptedList: (json['supplier_accepted_list'] as List<dynamic>?)
          ?.map(
              (e) => SupplierTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SupplierAcceptedTicketsResponseToJson(
        SupplierAcceptedTicketsResponse instance) =>
    <String, dynamic>{
      'supplier_accepted_list': instance.supplierAcceptedList,
      'meta_data': instance.metaData,
    };

SupplierDropOffTicketsResponse _$SupplierDropOffTicketsResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierDropOffTicketsResponse(
      supplierDropOffList: (json['supplier_drop_off_list'] as List<dynamic>?)
          ?.map(
              (e) => SupplierTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SupplierDropOffTicketsResponseToJson(
        SupplierDropOffTicketsResponse instance) =>
    <String, dynamic>{
      'supplier_drop_off_list': instance.supplierDropOffList,
      'meta_data': instance.metaData,
    };
