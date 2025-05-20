// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'car_drive_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CarDriveResponse {
  final String? carId;
  final String? plates;
  final String? type;
  final String? name;
  CarDriveResponse({
    this.carId,
    this.plates,
    this.type,
    this.name,
  });

  factory CarDriveResponse.fromJson(Map<String, dynamic> json) => _$CarDriveResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CarDriveResponseToJson(this);
}
