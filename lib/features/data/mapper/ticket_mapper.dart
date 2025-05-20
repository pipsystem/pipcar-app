import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/features/data/models/ticket_owner/customer_response.dart';
import 'package:pipcar/features/data/models/ticket_owner/ticket_details_response.dart';
import 'package:pipcar/features/data/models/ticket_owner/supplier_response.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_owner_process.dart';

import '../../domain/enterties/entities.dart';
import '../models/ticket_owner/owner_ticket_response.dart';

class TicketMapper {
  static TicketOwnerPassEntity fromOwnerTicketResponse(
      OwnerTicketResponse? response) {
    return TicketOwnerPassEntity(
      ticketId: response?.ticketId ?? "",
      carTypeName: response?.carTypeName ?? "",
      agencyId: response?.agencyId ?? "",
      description: response?.description ?? "",
      supplierId: response?.supplierId ?? "",
      coin: response?.coin ?? 0,
      statusName: response?.statusName ?? "",
      pickupDistrictName: response?.pickupDistrictName ?? "",
      pickupProvinceName: response?.pickupProvinceName ?? "",
      pickupTime: response?.pickupTime ?? "",
      waitCount: response?.waitCount ?? 0,
      ownerAvatar: isNullEmpty(response?.ownerAvatar)
          ? Assets.images.avtDefault.keyName
          : response!.ownerAvatar!,
      ownerName: response?.ownerName ?? '',
    );
  }

  static TicketOwnerAcceptedEntity fromOwnerAcceptedResponse(
      OwnerTicketResponse? response) {
    return TicketOwnerAcceptedEntity(
      ticketId: response?.ticketId ?? "",
      carTypeName: response?.carTypeName ?? "",
      agencyId: response?.agencyId ?? "",
      description: response?.description ?? "",
      supplierId: response?.supplierId ?? "",
      coin: response?.coin ?? 0,
      statusName: response?.statusName ?? "",
      pickupDistrictName: response?.pickupDistrictName ?? "",
      pickupProvinceName: response?.pickupProvinceName ?? "",
      pickupTime: response?.pickupTime ?? "",
      status: response?.status ?? 0,
      ownerAvatar: isNullEmpty(response?.ownerAvatar)
          ? Assets.images.avtDefault.keyName
          : response!.ownerAvatar!,
      ownerName: response?.ownerName ?? '',
    );
  }

  static TicketOwnerCompleteEntity fromOwnerCompleteResponse(
      OwnerTicketResponse response) {
    return TicketOwnerCompleteEntity(
      ticketId: response.ticketId ?? "",
      carTypeName: response.carTypeName ?? "",
      agencyId: response.agencyId ?? "",
      description: response.description ?? "",
      supplierId: response.supplierId ?? "",
      coin: response.coin ?? 0,
      statusName: response.statusName ?? "",
      pickupDistrictName: response.pickupDistrictName ?? "",
      pickupProvinceName: response.pickupProvinceName ?? "",
      pickupTime: response.pickupTime ?? "",
      ownerAvatar: isNullEmpty(response.ownerAvatar)
          ? Assets.images.avtDefault.keyName
          : response.ownerAvatar!,
      ownerName: response.ownerName ?? '',
    );
  }

  static TicketOwnerProcessEntity fromOwnerProcessResponse(
      OwnerTicketResponse? response) {
    return TicketOwnerProcessEntity(
      ticketId: response?.ticketId ?? "",
      carTypeName: response?.carTypeName ?? "",
      agencyId: response?.agencyId ?? "",
      description: response?.description ?? "",
      supplierId: response?.supplierId ?? "",
      coin: response?.coin ?? 0,
      statusName: response?.statusName ?? "",
      pickupDistrictName: response?.pickupDistrictName ?? "",
      pickupProvinceName: response?.pickupProvinceName ?? "",
      pickupTime: response?.pickupTime ?? "",
      ownerAvatar: isNullEmpty(response?.ownerAvatar)
          ? Assets.images.avtDefault.keyName
          : response!.ownerAvatar!,
      ownerName: response?.ownerName ?? '',
      status: response?.status ?? 0,
    );
  }

  static SupplierEntity fromSupplierResponse(SupplierResponse? response) {
    return SupplierEntity(
      id: response?.supplierId ?? "",
      supplierName: response?.supplierName ?? "",
      supplierPhone: response?.supplierPhone ?? "",
      carName: response?.carName ?? "",
      carPlates: response?.carPlate ?? "",
      carLat: response?.lat ?? "",
      carLong: response?.long ?? "",
      timeUpdate: response?.updatedGpsTime ?? "",
      carTypeName: response?.carTypeName ?? "",
      distance: response?.distance ?? "",
    );
  }

  static CustomerEntity fromCustomerResponse(CustomerResponse? response) {
    return CustomerEntity(
      customerId: response?.customerId ?? "",
      customerPhone: response?.customerPhone ?? "",
      customerName: response?.customerName ?? "",
    );
  }

  static DetailsPassTicket fromDetailsPassResponse(
      TicketDetailsResponse response) {
    return DetailsPassTicket(
        ticketInfor: fromOwnerTicketResponse(response.ticketInfo),
        suppliers: response.listSupplier != null
            ? response.listSupplier!
                .map((e) => fromSupplierResponse(e))
                .toList()
            : [],
        cusomerInfor: fromCustomerResponse(response.customerInfo!));
  }

  static DetailsAcceptedTicket fromDetailsAcceptedResponse(
      TicketDetailsResponse response) {
    return DetailsAcceptedTicket(
        ticketInfor: fromOwnerAcceptedResponse(response.ticketInfo),
        suppliers: response.listSupplier != null
            ? response.listSupplier!
                .map((e) => fromSupplierResponse(e))
                .toList()
            : [],
        cusomerInfor: fromCustomerResponse(response.customerInfo!));
  }

  static DetailsProcessTicket fromDetailsProcessResponse(
      TicketDetailsResponse response) {
    return DetailsProcessTicket(
        ticketInfor: fromOwnerProcessResponse(response.ticketInfo),
        suppliers: response.listSupplier != null
            ? response.listSupplier!
                .map((e) => fromSupplierResponse(e))
                .toList()
            : [],
        cusomerInfor: fromCustomerResponse(response.customerInfo!));
  }
}
