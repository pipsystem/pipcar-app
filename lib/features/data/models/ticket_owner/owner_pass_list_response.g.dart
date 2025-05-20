// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_pass_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerPassListResponse _$OwnerPassListResponseFromJson(
        Map<String, dynamic> json) =>
    OwnerPassListResponse(
      ownerPassList: (json['owner_pass_list'] as List<dynamic>?)
          ?.map((e) => OwnerTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OwnerPassListResponseToJson(
        OwnerPassListResponse instance) =>
    <String, dynamic>{
      'owner_pass_list': instance.ownerPassList,
      'metadata': instance.metadata,
    };
