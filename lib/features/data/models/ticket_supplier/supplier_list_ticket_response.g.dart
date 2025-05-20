// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_list_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierListTicketResponse _$SupplierListTicketResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierListTicketResponse(
      supplierNewList: (json['supplier_new_list'] as List<dynamic>?)
          ?.map(
              (e) => SupplierTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SupplierListTicketResponseToJson(
        SupplierListTicketResponse instance) =>
    <String, dynamic>{
      'supplier_new_list': instance.supplierNewList,
      'meta_data': instance.metaData,
    };
