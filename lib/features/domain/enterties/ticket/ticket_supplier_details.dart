// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../agency/agency_infor_entity.dart';
import 'details_ticket.dart';
import 'ticket_supplier.dart';

class TicketSupplierDetails {
  final TicketSupplierEntity ticketInfor;
  final CustomerEntity customerInfor;
  final AgencyInforEntity angencyInfor;
  final SupplierEntity supplier;
  final String carName;
  final String carPlates;
  final int coin;
  TicketSupplierDetails({
    required this.ticketInfor,
    required this.customerInfor,
    required this.angencyInfor,
    required this.supplier,
    required this.carName,
    required this.carPlates,
    required this.coin,
  });
}
