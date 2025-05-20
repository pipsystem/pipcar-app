import 'package:json_annotation/json_annotation.dart';

import 'owner_ticket_response.dart';

part 'owner_accepted_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OwnerAcceptedListResponse {
  final List<OwnerTicketResponse>? ownerAcceptedList;
  final Map<String, dynamic>? metadata;
  OwnerAcceptedListResponse({
    this.ownerAcceptedList,
    this.metadata,
  });

  factory OwnerAcceptedListResponse.fromJson(Map<String, dynamic> json) => _$OwnerAcceptedListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerAcceptedListResponseToJson(this);
}
