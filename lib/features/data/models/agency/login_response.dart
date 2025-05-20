import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoginResponse {
  final String? refreshToken;
  final String? accessToken;

  LoginResponse({this.refreshToken, this.accessToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
