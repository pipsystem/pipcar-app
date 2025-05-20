// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'infor_driver_dispatch_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DriverInforDisptachResponse {
  final String? agencyId;
  final String? driverName;
  final String? driverPhone;
  final String? carPlate;
  final String? carName;
  final String? carTypeName;
  final int? carTypeId;
  final int? currentMonth;
  final CurrentTicketResponse? currentTicket;
  DriverInforDisptachResponse({
    this.agencyId,
    this.driverName,
    this.driverPhone,
    this.carPlate,
    this.carName,
    this.carTypeName,
    this.carTypeId,
    this.currentMonth,
    this.currentTicket,
  });

  factory DriverInforDisptachResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverInforDisptachResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DriverInforDisptachResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentTicketResponse {
  final String? pickpTime;
  final String? description;
  final String? ticketId;
  CurrentTicketResponse({
    this.pickpTime,
    this.description,
    this.ticketId,
  });

  factory CurrentTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentTicketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentTicketResponseToJson(this);
}
