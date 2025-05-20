// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'agency_infor_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AgencyInforResponse {
  final String? agencyId;
  final String? agencyPhone;
  final String? agencyName;
  AgencyInforResponse({
    this.agencyId,
    this.agencyPhone,
    this.agencyName,
  });

  factory AgencyInforResponse.fromJson(Map<String, dynamic> json) => _$AgencyInforResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyInforResponseToJson(this);
}
