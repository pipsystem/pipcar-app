import 'package:json_annotation/json_annotation.dart';

import 'owner_ticket_response.dart';

part 'owner_complete_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OwnerCompleteListResponse {
  final List<OwnerTicketResponse>? ownerCompleteList;
  final Map<String, dynamic>? metadata;
  OwnerCompleteListResponse({
    this.ownerCompleteList,
    this.metadata,
  });

  factory OwnerCompleteListResponse.fromJson(Map<String, dynamic> json) => _$OwnerCompleteListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerCompleteListResponseToJson(this);
}
