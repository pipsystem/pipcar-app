// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_ticket_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierTicketResponse _$SupplierTicketResponseFromJson(
        Map<String, dynamic> json) =>
    SupplierTicketResponse(
      ticketId: json['ticket_id'] as String?,
      carTypeName: json['car_type_name'] as String?,
      agencyId: json['agency_id'] as String?,
      description: json['description'] as String?,
      supplierId: json['supplier_id'] as String?,
      coin: json['coin'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pickupTime: json['pickup_time'] as String?,
      pickupProvinceName: json['pickup_province_name'] as String?,
      pickupDistrictName: json['pickup_district_name'] as String?,
      dropoffTime: json['dropoff_time'] as String?,
      dropoffProvinceName: json['dropoff_province_name'] as String?,
      dropoffDistrictName: json['dropoff_district_name'] as String?,
      statusName: json['status_name'] as String?,
      ownerName: json['owner_name'] as String?,
      ownerAvatar: json['owner_avatar'] as String?,
      status: json['status'] as int?,
      isNavigate: json['is_navigate'] as bool?,
    );

Map<String, dynamic> _$SupplierTicketResponseToJson(
        SupplierTicketResponse instance) =>
    <String, dynamic>{
      'ticket_id': instance.ticketId,
      'car_type_name': instance.carTypeName,
      'agency_id': instance.agencyId,
      'description': instance.description,
      'supplier_id': instance.supplierId,
      'coin': instance.coin,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pickup_time': instance.pickupTime,
      'pickup_province_name': instance.pickupProvinceName,
      'pickup_district_name': instance.pickupDistrictName,
      'dropoff_time': instance.dropoffTime,
      'dropoff_province_name': instance.dropoffProvinceName,
      'dropoff_district_name': instance.dropoffDistrictName,
      'status_name': instance.statusName,
      'owner_name': instance.ownerName,
      'owner_avatar': instance.ownerAvatar,
      'status': instance.status,
      'is_navigate': instance.isNavigate,
    };
