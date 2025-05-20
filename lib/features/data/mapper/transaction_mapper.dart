import 'package:pipcar/features/data/models/transaction/transaction_item_reponse.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';

import '../../domain/enterties/transaction/transaction_detail_entity.dart';
import '../models/transaction/transaction_details_response.dart';

class TransactionMapper {
  static TransactionItemEntity convertTransactionItem(
          TransactionItemResponse response) =>
      TransactionItemEntity(
          transactionCoinId: response.transactionCoinId ?? '',
          ticketId: response.ticketId ?? '',
          amount: response.amount ?? 0,
          type: response.type ?? 0,
          description: response.description ?? '',
          newBalance: response.newBalance ?? 0,
          updateTime: response.updateTime ?? '');

  static TransactionDetailEntity converTransactionDetail(
          TransactionDetailsResponse response) =>
      TransactionDetailEntity(
          transactionId: response.transactionCoinId ?? '',
          ticketId: response.ticketInfo?.ticketId ?? "",
          type: response.type ?? 0,
          amount: response.amount ?? 0,
          updateTime: response.updateTime ?? "",
          balance: response.newBalance ?? 0,
          description: response.description ?? "",
          ticketInfor: TicketInforEntity(
              ticketId: response.ticketInfo?.ticketId ?? '',
              carTypeName: response.ticketInfo?.carTypeName ?? '',
              agencyId: response.ticketInfo?.agencyId ?? '',
              description: response.ticketInfo?.description ?? '',
              supplierId: response.ticketInfo?.supplierId ?? '',
              coin: response.ticketInfo?.coin ?? 0,
              dropoffProvince: response.ticketInfo?.dropoffProvince ?? '',
              dropoffDistrict: response.ticketInfo?.dropoffDistrict ?? '',
              dropoffTime: response.ticketInfo?.dropoffTime ?? '',
              isNavigate: response.ticketInfo?.isNavigate ?? false,
              createdAt: response.ticketInfo?.createdAt ?? '',
              updatedAt: response.ticketInfo?.updatedAt ?? '',
              pickupTime: response.ticketInfo?.pickupTime ?? '',
              pickupProvinceName: response.ticketInfo?.pickupProvinceName ?? '',
              pickupDistrictName: response.ticketInfo?.pickupDistrictName ?? '',
              statusName: response.ticketInfo?.statusName ?? '',
              status: response.ticketInfo?.status ?? 0));
}
