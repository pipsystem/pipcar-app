import 'package:json_annotation/json_annotation.dart';

part 'current_agency_infor_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentAgencyInforResponse {
  final String? carName;
  final String? carPlate;
  final int? coin;
  CurrentAgencyInforResponse({
    this.carName,
    this.carPlate,
    this.coin,
  });
  factory CurrentAgencyInforResponse.fromJson(Map<String, dynamic> json) => _$CurrentAgencyInforResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentAgencyInforResponseToJson(this);
}
