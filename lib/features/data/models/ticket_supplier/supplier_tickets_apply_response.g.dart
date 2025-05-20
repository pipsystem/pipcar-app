// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_tickets_apply_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierTicketsApplyResponse _$SupplierTicketsApplyResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierTicketsApplyResponse(
      supplierApplyList: (json['supplier_apply_list'] as List<dynamic>?)
          ?.map(
              (e) => SupplierTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaData: json['meta_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SupplierTicketsApplyResponseToJson(
        SupplierTicketsApplyResponse instance) =>
    <String, dynamic>{
      'supplier_apply_list': instance.supplierApplyList,
      'meta_data': instance.metaData,
    };
