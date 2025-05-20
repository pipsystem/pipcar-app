// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'owner_ticket_response.dart';

part 'owner_pass_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OwnerPassListResponse {
  final List<OwnerTicketResponse>? ownerPassList;
  final Map<String, dynamic>? metadata;
  OwnerPassListResponse({
    this.ownerPassList,
    this.metadata,
  });

  factory OwnerPassListResponse.fromJson(Map<String, dynamic> json) => _$OwnerPassListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerPassListResponseToJson(this);
}
