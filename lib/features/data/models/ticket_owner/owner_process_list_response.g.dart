// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_process_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerProcessListResponse _$OwnerProcessListResponseFromJson(
        Map<String, dynamic> json) =>
    OwnerProcessListResponse(
      ownerProcessList: (json['owner_process_list'] as List<dynamic>?)
          ?.map((e) => OwnerTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OwnerProcessListResponseToJson(
        OwnerProcessListResponse instance) =>
    <String, dynamic>{
      'owner_process_list': instance.ownerProcessList,
      'metadata': instance.metadata,
    };
