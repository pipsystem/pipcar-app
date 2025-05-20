// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'car_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CarResponse {
  final String? carId;
  final String? agencyId;
  final String? plates;
  final String? type;
  final int? carTypeId;
  final String? name;
  final String? lat;
  final String? long;
  final String? updatedGpsTime;
  CarResponse({
    this.carId,
    this.agencyId,
    this.plates,
    this.type,
    this.carTypeId,
    this.name,
    this.lat,
    this.long,
    this.updatedGpsTime,
  });

  factory CarResponse.fromJson(Map<String, dynamic> json) =>
      _$CarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CarResponseToJson(this);
}
