// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'base_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  List<T>? data;
  @JsonKey(name: 'errors')
  dynamic errors;

  BaseListResponse({this.status, this.message, this.data, this.errors});

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseListResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseListResponseToJson(this, toJsonT);

  @override
  String toString() {
    return 'status: $status, message: $message, data: $data, errors: $errors';
  }
}
