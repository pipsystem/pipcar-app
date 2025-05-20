// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'analyst_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnalystResponse {
  final double? revenue;
  final double? cost;
  final double? profit;
  final int? currentMonth;
  AnalystResponse({
    this.revenue,
    this.cost,
    this.profit,
    this.currentMonth,
  });

  factory AnalystResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalystResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnalystResponseToJson(this);
}
