// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_item_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItemResponse _$TransactionItemResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionItemResponse(
      transactionCoinId: json['transaction_coin_id'] as String?,
      ticketId: json['ticket_id'] as String?,
      amount: json['amount'] as int?,
      type: json['type'] as int?,
      description: json['description'] as String?,
      newBalance: json['new_balance'] as int?,
      updateTime: json['update_time'] as String?,
    );

Map<String, dynamic> _$TransactionItemResponseToJson(
        TransactionItemResponse instance) =>
    <String, dynamic>{
      'transaction_coin_id': instance.transactionCoinId,
      'ticket_id': instance.ticketId,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'new_balance': instance.newBalance,
      'update_time': instance.updateTime,
    };
