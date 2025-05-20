// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'address_search_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressSearchResponse {
  final String? id;
  final String? addressName;
  final String? addressNameIndex;
  final String? provinceId;
  AddressSearchResponse({
    this.id,
    this.addressName,
    this.addressNameIndex,
    this.provinceId,
  });

  factory AddressSearchResponse.fromJson(Map<String, dynamic> json) => _$AddressSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressSearchResponseToJson(this);
}
