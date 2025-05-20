// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'car_response.dart';

part 'car_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CarListResponse {
  final List<CarResponse> carList;
  CarListResponse({
    required this.carList,
  });

  factory CarListResponse.fromJson(Map<String, dynamic> json) => _$CarListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CarListResponseToJson(this);
}
