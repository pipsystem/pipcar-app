import 'package:json_annotation/json_annotation.dart';

part 'checkRT_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CheckRTResponse {
  final String accessToken;

  CheckRTResponse({required this.accessToken});

  factory CheckRTResponse.fromJson(Map<String, dynamic> json) => _$CheckRTResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckRTResponseToJson(this);
}
