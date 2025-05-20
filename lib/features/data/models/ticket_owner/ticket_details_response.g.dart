// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketDetailsResponse _$TicketDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    TicketDetailsResponse(
      ticketInfo: json['ticket_info'] == null
          ? null
          : OwnerTicketResponse.fromJson(
              json['ticket_info'] as Map<String, dynamic>),
      listSupplier: (json['list_supplier'] as List<dynamic>?)
          ?.map((e) => SupplierResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerInfo: json['customer_info'] == null
          ? null
          : CustomerResponse.fromJson(
              json['customer_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketDetailsResponseToJson(
        TicketDetailsResponse instance) =>
    <String, dynamic>{
      'ticket_info': instance.ticketInfo,
      'list_supplier': instance.listSupplier,
      'customer_info': instance.customerInfo,
    };
