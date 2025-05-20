import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/features/data/models/ticket_supplier/supplier_new_ticket_details_response.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';

import '../../../common/assets/assets.gen.dart';
import '../models/models.dart';
import 'ticket_mapper.dart';

class TicketSupplierMapper {
  static TicketSupplierEntity fromSupplierTicket(
      SupplierTicketResponse response) {
    return TicketSupplierEntity(
        ticketId: response.ticketId ?? "",
        carTypeName: response.carTypeName ?? "",
        agencyId: response.agencyId ?? "",
        description: response.description ?? "",
        supplierId: response.supplierId ?? "",
        coin: response.coin ?? 0,
        createdAt: response.createdAt ?? "",
        updatedAt: response.updatedAt ?? "",
        pickupTime: response.pickupTime ?? "",
        pickupProvinceName: response.pickupProvinceName ?? "",
        pickupDistrictName: response.pickupDistrictName ?? "",
        dropOffTime: response.dropoffTime ?? "",
        dropOffProvinceName: response.dropoffProvinceName ?? "",
        dropOffDistrictName: response.dropoffDistrictName ?? "",
        statusName: response.statusName ?? "",
        isNavigate: response.isNavigate ?? false,
        ownerAvatar: isNullEmpty(response.ownerAvatar)
            ? Assets.images.avtDefault.keyName
            : response.ownerAvatar!,
        ownerName: response.ownerName ?? '',
        status: response.status ?? 0);
  }

  static TicketSupplierDetails converTicketSupplierDetails(
      SupplierNewTicketDetailsResponse response) {
    return TicketSupplierDetails(
        ticketInfor: fromSupplierTicket(response.ticketInfo!),
        customerInfor: TicketMapper.fromCustomerResponse(response.customerInfo),
        angencyInfor: AgencyInforEntity(
            agencyId: response.agencyInfo?.agencyId ?? "",
            name: response.agencyInfo?.agencyName ?? "",
            phone: response.agencyInfo?.agencyPhone ?? "",
            isTransportation: false,
            isDriver: false,
            coin: 0,
            point: 0,
            carTypeId: 0,
            agencyType: ""),
        supplier: SupplierEntity(
            supplierName: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.supplierName ?? ""
                : "",
            supplierPhone: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.supplierPhone ?? ""
                : "",
            id: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.supplierId ?? ""
                : "",
            carName: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.carName ?? ""
                : "",
            carPlates: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.carPlate ?? ""
                : "",
            carLat: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.lat ?? ""
                : "",
            carLong: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.long ?? ""
                : "",
            timeUpdate: !isNullEmptyList(response.listSupplier)
                ? response.listSupplier?.first.updatedGpsTime ?? ""
                : "",
            carTypeName: "carTypeName",
            distance: "distance"),
        carName: response.currentAgencyInfo?.carName ?? "",
        carPlates: response.currentAgencyInfo?.carPlate ?? "",
        coin: response.currentAgencyInfo?.coin ?? 0);
  }
}
