// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerTicketResponse _$OwnerTicketResponseFromJson(Map<String, dynamic> json) =>
    OwnerTicketResponse(
      ticketId: json['ticket_id'] as String?,
      carTypeName: json['car_type_name'] as String?,
      agencyId: json['agency_id'] as String?,
      description: json['description'] as String?,
      supplierId: json['supplier_id'] as String?,
      coin: json['coin'] as int?,
      pickupProvinceName: json['pickup_province_name'] as String?,
      pickupDistrictName: json['pickup_district_name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pickupTime: json['pickup_time'] as String?,
      statusName: json['status_name'] as String?,
      ownerName: json['owner_name'] as String?,
      ownerAvatar: json['owner_avatar'] as String?,
      waitCount: json['wait_count'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$OwnerTicketResponseToJson(
        OwnerTicketResponse instance) =>
    <String, dynamic>{
      'ticket_id': instance.ticketId,
      'car_type_name': instance.carTypeName,
      'agency_id': instance.agencyId,
      'description': instance.description,
      'supplier_id': instance.supplierId,
      'coin': instance.coin,
      'pickup_province_name': instance.pickupProvinceName,
      'pickup_district_name': instance.pickupDistrictName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pickup_time': instance.pickupTime,
      'status_name': instance.statusName,
      'owner_name': instance.ownerName,
      'owner_avatar': instance.ownerAvatar,
      'wait_count': instance.waitCount,
      'status': instance.status,
    };
