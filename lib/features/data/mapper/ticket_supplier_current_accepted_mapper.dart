import 'package:pipcar/features/data/models/ticket_supplier/supplier_current_accepted_ticket_response.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_supplier_current.dart';


class TicketSupplierCurrentAcceptedMapper {
  static TicketSupplierCurrentEntity fromSupplierTicket(
      SupplierCurentAcceptedTicketsResponse response) {
    return TicketSupplierCurrentEntity(currentTicketId: response.currentTicketId ?? "");
  }
}
