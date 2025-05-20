// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'driver_delivering_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ListDeliveringResponse {
  final List<DriverDeliveringResponse>? driverList;
  ListDeliveringResponse({
    this.driverList,
  });

  factory ListDeliveringResponse.fromJson(Map<String, dynamic> json) =>
      _$ListDeliveringResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListDeliveringResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DriverDeliveringResponse {
  final String? agencyId;
  final String? driverPhone;
  final String? driverName;
  final String? carName;
  final String? carPlate;
  final bool? isDriving;
  DriverDeliveringResponse({
    this.agencyId,
    this.driverPhone,
    this.driverName,
    this.carName,
    this.carPlate,
    this.isDriving,
  });

  factory DriverDeliveringResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverDeliveringResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDeliveringResponseToJson(this);
}
