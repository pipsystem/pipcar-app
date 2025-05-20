import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../repository/ticket_owner_repository.dart';

@injectable
class TicketOwnerUseCase {
  final TicketOwnerRepository _repository;

  TicketOwnerUseCase(this._repository);

  Future<Either<Exception, dynamic>> createTicket({
    required String desciption,
    required int carTypeId,
    required int coin,
    required int provinceId,
    required int districtId,
    required String pickUpTime,
  }) async {
    final result = await _repository.createTicket(
      desciption: desciption,
      carTypeId: carTypeId,
      coin: coin,
      provinceId: provinceId,
      districtId: districtId,
      pickUpTime: pickUpTime,
    );
    return result;
  }

  Future<Either<Exception, dynamic>> createTicketNavigate({
    required String supplierId,
    required String desciption,
    required int provincePickId,
    required int districtPickId,
    required int provinceDropId,
    required int districtDropId,
    required int carTypeId,
    required String pickUpTime,
    required String dropOffTime,
  }) async {
    final result = await _repository.createTicketNavigate(
      supplierId: supplierId,
      desciption: desciption,
      provincePickId: provincePickId,
      districtPickId: districtPickId,
      provinceDropId: provinceDropId,
      districtDropId: districtDropId,
      pickUpTime: pickUpTime,
      carTypeId: carTypeId,
      dropOffTime: dropOffTime,
    );
    return result;
  }

  Future<Either<Exception, dynamic>> getPassList({required int page}) async {
    final result = await _repository.getPassList(page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getAcceptedList(
      {required int page}) async {
    final result = await _repository.getAcceptedList(page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getCompleteList(
      {required int page}) async {
    final result = await _repository.getCompleteList(page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getProcessList(
      {required int page}) async {
    final result = await _repository.getProcessList(page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsPassTicket(
      {required String ticketId}) async {
    final result = await _repository.getDetailsPassTicket(ticketId: ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsAcceptedTicket(
      {required String ticketId}) async {
    final result =
        await _repository.getDetailsAcceptedTicket(ticketId: ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsCompleteTicket(
      {required String ticketId}) async {
    final result =
        await _repository.getDetailsCompleteTicket(ticketId: ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsProcessTicket(
      {required String ticketId}) async {
    final result =
        await _repository.getDetailsProcessTicket(ticketId: ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> cancelTicket(
      {required String ticketId}) async {
    var body = {'ticket_id': ticketId};
    final result = await _repository.cancelTicket(body);
    return result;
  }

  Future<Either<Exception, dynamic>> completeTicket(
      {required String ticketId}) async {
    var body = {'ticket_id': ticketId};
    final result = await _repository.completeTicket(body);
    return result;
  }

  Future<Either<Exception, dynamic>> acceptTicket(
      {required String ticketId, required String supplierId}) async {
    var body = {'ticket_id': ticketId, 'supplier_id': supplierId};
    final result = await _repository.acceptTicket(body);
    return result;
  }

  Future<Either<Exception, dynamic>> updateTicketCustomer(
      {required String ticketId,
      required String customerName,
      required String customerPhone}) async {
    var body = {
      'ticket_id': ticketId,
      'customer_name': customerName,
      'customer_phone': customerPhone
    };
    final result = await _repository.updateTicketCustomer(body);
    return result;
  }
}
