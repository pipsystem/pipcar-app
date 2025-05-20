import 'package:json_annotation/json_annotation.dart';

part 'agency_search_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AgencySearchResponse {
  final int? rank;
  final String? carName;
  final String? carPlates;
  final String? agencyId;
  final String? carId;
  final String? carLat;
  final String? carLong;
  final String? avatar;
  final String? updatedGpsTime;
  final String? distance1;
  final double? distance;

  AgencySearchResponse({
    this.rank,
    this.carName,
    this.carPlates,
    this.agencyId,
    this.carId,
    this.carLat,
    this.carLong,
    this.avatar,
    this.updatedGpsTime,
    this.distance1,
    this.distance,
  });

  factory AgencySearchResponse.fromJson(Map<String, dynamic> json) => _$AgencySearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgencySearchResponseToJson(this);
}
