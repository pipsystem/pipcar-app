// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infor_driver_dispatch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverInforDisptachResponse _$DriverInforDisptachResponseFromJson(
        Map<String, dynamic> json) =>
    DriverInforDisptachResponse(
      agencyId: json['agency_id'] as String?,
      driverName: json['driver_name'] as String?,
      driverPhone: json['driver_phone'] as String?,
      carPlate: json['car_plate'] as String?,
      carName: json['car_name'] as String?,
      carTypeName: json['car_type_name'] as String?,
      carTypeId: json['car_type_id'] as int?,
      currentMonth: json['current_month'] as int?,
      currentTicket: json['current_ticket'] == null
          ? null
          : CurrentTicketResponse.fromJson(
              json['current_ticket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DriverInforDisptachResponseToJson(
        DriverInforDisptachResponse instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'driver_name': instance.driverName,
      'driver_phone': instance.driverPhone,
      'car_plate': instance.carPlate,
      'car_name': instance.carName,
      'car_type_name': instance.carTypeName,
      'car_type_id': instance.carTypeId,
      'current_month': instance.currentMonth,
      'current_ticket': instance.currentTicket,
    };

CurrentTicketResponse _$CurrentTicketResponseFromJson(
        Map<String, dynamic> json) =>
    CurrentTicketResponse(
      pickpTime: json['pickp_time'] as String?,
      description: json['description'] as String?,
      ticketId: json['ticket_id'] as String?,
    );

Map<String, dynamic> _$CurrentTicketResponseToJson(
        CurrentTicketResponse instance) =>
    <String, dynamic>{
      'pickp_time': instance.pickpTime,
      'description': instance.description,
      'ticket_id': instance.ticketId,
    };
