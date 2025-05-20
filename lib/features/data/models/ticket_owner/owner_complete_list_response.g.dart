// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_complete_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerCompleteListResponse _$OwnerCompleteListResponseFromJson(
        Map<String, dynamic> json) =>
    OwnerCompleteListResponse(
      ownerCompleteList: (json['owner_complete_list'] as List<dynamic>?)
          ?.map((e) => OwnerTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OwnerCompleteListResponseToJson(
        OwnerCompleteListResponse instance) =>
    <String, dynamic>{
      'owner_complete_list': instance.ownerCompleteList,
      'metadata': instance.metadata,
    };
