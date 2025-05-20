// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_complete_tickets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierCompleteTicketsResponse _$SupplierCompleteTicketsResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierCompleteTicketsResponse(
      supplierCompleteList: (json['supplier_complete_list'] as List<dynamic>?)
          ?.map(
              (e) => SupplierTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SupplierCompleteTicketsResponseToJson(
        SupplierCompleteTicketsResponse instance) =>
    <String, dynamic>{
      'supplier_complete_list': instance.supplierCompleteList,
      'meta_data': instance.metaData,
    };
