// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'analyst_expense_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnalystExpenseResponse {
  final List<DriverSalaryItemResponse>? driverSalaryList;
  final double? totalSalary;
  final double? totalTicketCost;
  final double? otherCost;
  AnalystExpenseResponse({
    this.driverSalaryList,
    this.totalSalary,
    this.totalTicketCost,
    this.otherCost,
  });

  factory AnalystExpenseResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalystExpenseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnalystExpenseResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DriverSalaryItemResponse {
  final String? agencyId;
  final String? driverName;
  final String? driverPhone;
  final double? driverSalary;
  DriverSalaryItemResponse({
    this.agencyId,
    this.driverName,
    this.driverPhone,
    this.driverSalary,
  });

  factory DriverSalaryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverSalaryItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverSalaryItemResponseToJson(this);
}
