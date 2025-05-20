// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_owner_process.dart';

import '../agency/agency_search_entity.dart';
import 'ticket_owner_pass.dart';

class DetailsPassTicket {
  final TicketOwnerPassEntity ticketInfor;
  final List<SupplierEntity> suppliers;
  final CustomerEntity cusomerInfor;
  DetailsPassTicket({
    required this.ticketInfor,
    required this.suppliers,
    required this.cusomerInfor,
  });
}

class DetailsAcceptedTicket {
  final TicketOwnerAcceptedEntity ticketInfor;
  final List<SupplierEntity> suppliers;
  final CustomerEntity cusomerInfor;
  DetailsAcceptedTicket({
    required this.ticketInfor,
    required this.suppliers,
    required this.cusomerInfor,
  });
}

class DetailsProcessTicket {
  final TicketOwnerProcessEntity ticketInfor;
  final List<SupplierEntity> suppliers;
  final CustomerEntity cusomerInfor;
  DetailsProcessTicket({
    required this.ticketInfor,
    required this.suppliers,
    required this.cusomerInfor,
  });
}

class SupplierEntity extends CarDetailsBase {
  final String supplierName;
  final String supplierPhone;
  final String distance;

  SupplierEntity({
    required this.supplierName,
    required this.supplierPhone,
    required super.id,
    required super.carName,
    required super.carPlates,
    required super.carLat,
    required super.carLong,
    required super.timeUpdate,
    required super.carTypeName,
    required this.distance,
  });
}

class CustomerEntity {
  final String customerId;
  final String customerPhone;
  final String customerName;
  CustomerEntity({
    required this.customerId,
    required this.customerPhone,
    required this.customerName,
  });
}
