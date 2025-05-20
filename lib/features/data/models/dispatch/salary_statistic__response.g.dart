// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_statistic__response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalaryStatisticResponse _$SalaryStatisticResponseFromJson(
        Map<String, dynamic> json) =>
    SalaryStatisticResponse(
      month: json['month'] as int?,
      totalSalary: (json['totalSalary'] as num?)?.toDouble(),
      profit: (json['profit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SalaryStatisticResponseToJson(
        SalaryStatisticResponse instance) =>
    <String, dynamic>{
      'month': instance.month,
      'totalSalary': instance.totalSalary,
      'profit': instance.profit,
    };
