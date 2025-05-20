// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_accepted_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerAcceptedListResponse _$OwnerAcceptedListResponseFromJson(
        Map<String, dynamic> json) =>
    OwnerAcceptedListResponse(
      ownerAcceptedList: (json['owner_accepted_list'] as List<dynamic>?)
          ?.map((e) => OwnerTicketResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OwnerAcceptedListResponseToJson(
        OwnerAcceptedListResponse instance) =>
    <String, dynamic>{
      'owner_accepted_list': instance.ownerAcceptedList,
      'metadata': instance.metadata,
    };
