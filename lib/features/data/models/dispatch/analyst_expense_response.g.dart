// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyst_expense_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalystExpenseResponse _$AnalystExpenseResponseFromJson(
        Map<String, dynamic> json) =>
    AnalystExpenseResponse(
      driverSalaryList: (json['driver_salary_list'] as List<dynamic>?)
          ?.map((e) =>
              DriverSalaryItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSalary: (json['total_salary'] as num?)?.toDouble(),
      totalTicketCost: (json['total_ticket_cost'] as num?)?.toDouble(),
      otherCost: (json['other_cost'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AnalystExpenseResponseToJson(
        AnalystExpenseResponse instance) =>
    <String, dynamic>{
      'driver_salary_list': instance.driverSalaryList,
      'total_salary': instance.totalSalary,
      'total_ticket_cost': instance.totalTicketCost,
      'other_cost': instance.otherCost,
    };

DriverSalaryItemResponse _$DriverSalaryItemResponseFromJson(
        Map<String, dynamic> json) =>
    DriverSalaryItemResponse(
      agencyId: json['agency_id'] as String?,
      driverName: json['driver_name'] as String?,
      driverPhone: json['driver_phone'] as String?,
      driverSalary: (json['driver_salary'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DriverSalaryItemResponseToJson(
        DriverSalaryItemResponse instance) =>
    <String, dynamic>{
      'agency_id': instance.agencyId,
      'driver_name': instance.driverName,
      'driver_phone': instance.driverPhone,
      'driver_salary': instance.driverSalary,
    };
