// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  dynamic data;
  @JsonKey(name: 'errors')
  dynamic errors;

  BaseResponse({this.status, this.message, this.data, this.errors});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

  @override
  String toString() {
    return 'status: $status, message: $message, data: $data, errors: $errors';
  }
}
