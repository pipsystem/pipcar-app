// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyst_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalystResponse _$AnalystResponseFromJson(Map<String, dynamic> json) =>
    AnalystResponse(
      revenue: (json['revenue'] as num?)?.toDouble(),
      cost: (json['cost'] as num?)?.toDouble(),
      profit: (json['profit'] as num?)?.toDouble(),
      currentMonth: json['current_month'] as int?,
    );

Map<String, dynamic> _$AnalystResponseToJson(AnalystResponse instance) =>
    <String, dynamic>{
      'revenue': instance.revenue,
      'cost': instance.cost,
      'profit': instance.profit,
      'current_month': instance.currentMonth,
    };
