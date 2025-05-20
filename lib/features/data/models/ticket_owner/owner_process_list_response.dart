// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'owner_ticket_response.dart';

part 'owner_process_list_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OwnerProcessListResponse {
  final List<OwnerTicketResponse>? ownerProcessList;
  final Map<String, dynamic>? metadata;
  OwnerProcessListResponse({
    this.ownerProcessList,
    this.metadata,
  });

  factory OwnerProcessListResponse.fromJson(Map<String, dynamic> json) => _$OwnerProcessListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerProcessListResponseToJson(this);
}
