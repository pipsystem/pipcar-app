// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'salary_statistic__response.g.dart';

@JsonSerializable()
class SalaryStatisticResponse {
  final int? month;
  final double? totalSalary;
  final double? profit;
  SalaryStatisticResponse({
    this.month,
    this.totalSalary,
    this.profit,
  });

  factory SalaryStatisticResponse.fromJson(Map<String, dynamic> json) =>
      _$SalaryStatisticResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalaryStatisticResponseToJson(this);
}
