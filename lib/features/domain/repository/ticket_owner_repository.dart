import 'package:either_dart/either.dart';

abstract class TicketOwnerRepository {
  Future<Either<Exception, dynamic>> createTicket({
    required String desciption,
    required int carTypeId,
    required int coin,
    required int provinceId,
    required int districtId,
    required String pickUpTime,
  });

  Future<Either<Exception, dynamic>> createTicketNavigate({
    required String supplierId,
    required String desciption,
    required int provincePickId,
    required int districtPickId,
    required int provinceDropId,
    required int districtDropId,
    required String pickUpTime,
    required int carTypeId,
    required String dropOffTime,
  });

  Future<Either<Exception, dynamic>> getPassList({required int page});

  Future<Either<Exception, dynamic>> getAcceptedList({required int page});

  Future<Either<Exception, dynamic>> getCompleteList({required int page});

  Future<Either<Exception, dynamic>> getProcessList({required int page});

  Future<Either<Exception, dynamic>> getDetailsPassTicket(
      {required String ticketId});

  Future<Either<Exception, dynamic>> getDetailsAcceptedTicket(
      {required String ticketId});

  Future<Either<Exception, dynamic>> getDetailsCompleteTicket(
      {required String ticketId});

  Future<Either<Exception, dynamic>> getDetailsProcessTicket(
      {required String ticketId});

  Future<Either<Exception, dynamic>> cancelTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> acceptTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> completeTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> updateTicketCustomer(
      Map<String, dynamic> body);
}
