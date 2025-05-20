// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailsResponse _$TransactionDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailsResponse(
      transactionCoinId: json['transaction_coin_id'] as String?,
      amount: json['amount'] as int?,
      type: json['type'] as int?,
      description: json['description'] as String?,
      newBalance: json['new_balance'] as int?,
      updateTime: json['update_time'] as String?,
      ticketInfo: json['ticket_info'] == null
          ? null
          : TicketInforResponse.fromJson(
              json['ticket_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionDetailsResponseToJson(
        TransactionDetailsResponse instance) =>
    <String, dynamic>{
      'transaction_coin_id': instance.transactionCoinId,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'new_balance': instance.newBalance,
      'update_time': instance.updateTime,
      'ticket_info': instance.ticketInfo,
    };

TicketInforResponse _$TicketInforResponseFromJson(Map<String, dynamic> json) =>
    TicketInforResponse(
      ticketId: json['ticket_id'] as String?,
      carTypeName: json['car_type_name'] as String?,
      agencyId: json['agency_id'] as String?,
      description: json['description'] as String?,
      supplierId: json['supplier_id'] as String?,
      coin: json['coin'] as int?,
      dropoffProvince: json['dropoff_province'] as String?,
      dropoffDistrict: json['dropoff_district'] as String?,
      dropoffTime: json['dropoff_time'] as String?,
      isNavigate: json['is_navigate'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pickupTime: json['pickup_time'] as String?,
      pickupProvinceName: json['pickup_province_name'] as String?,
      pickupDistrictName: json['pickup_district_name'] as String?,
      statusName: json['status_name'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$TicketInforResponseToJson(
        TicketInforResponse instance) =>
    <String, dynamic>{
      'ticket_id': instance.ticketId,
      'car_type_name': instance.carTypeName,
      'agency_id': instance.agencyId,
      'description': instance.description,
      'supplier_id': instance.supplierId,
      'coin': instance.coin,
      'dropoff_province': instance.dropoffProvince,
      'dropoff_district': instance.dropoffDistrict,
      'dropoff_time': instance.dropoffTime,
      'is_navigate': instance.isNavigate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pickup_time': instance.pickupTime,
      'pickup_province_name': instance.pickupProvinceName,
      'pickup_district_name': instance.pickupDistrictName,
      'status_name': instance.statusName,
      'status': instance.status,
    };
