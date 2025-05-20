// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_new_ticket_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierNewTicketDetailsResponse _$SupplierNewTicketDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierNewTicketDetailsResponse(
      ticketInfo: json['ticket_info'] == null
          ? null
          : SupplierTicketResponse.fromJson(
              json['ticket_info'] as Map<String, dynamic>),
      currentAgencyInfo: json['current_agency_info'] == null
          ? null
          : CurrentAgencyInforResponse.fromJson(
              json['current_agency_info'] as Map<String, dynamic>),
      listSupplier: (json['list_supplier'] as List<dynamic>?)
          ?.map((e) => SupplierResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      agencyInfo: json['agency_info'] == null
          ? null
          : AgencyInforResponse.fromJson(
              json['agency_info'] as Map<String, dynamic>),
      customerInfo: json['customer_info'] == null
          ? null
          : CustomerResponse.fromJson(
              json['customer_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SupplierNewTicketDetailsResponseToJson(
        SupplierNewTicketDetailsResponse instance) =>
    <String, dynamic>{
      'ticket_info': instance.ticketInfo,
      'current_agency_info': instance.currentAgencyInfo,
      'list_supplier': instance.listSupplier,
      'agency_info': instance.agencyInfo,
      'customer_info': instance.customerInfo,
    };
