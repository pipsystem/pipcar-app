import 'package:either_dart/either.dart';

abstract class TicketSupplierRepository {
  Future<Either<Exception, dynamic>> getNewScheduleList(
      {String? supplierId, required int page});

  Future<Either<Exception, dynamic>> getDetailsNewTicket(String ticketId);

  Future<Either<Exception, dynamic>> getApplySchedules(
      {String? supplierId, required int page});

  Future<Either<Exception, dynamic>> getDetailsMyApplyTicket(String ticketId);

  Future<Either<Exception, dynamic>> getMyCompleteSchedules(
      {required int page, String? supplierId});

  Future<Either<Exception, dynamic>> getDetailsMyCompleteTicket(
      String ticketId);

  Future<Either<Exception, dynamic>> getMyAcceptedSchedules(
      {required int page, String? supplierId});

  Future<Either<Exception, dynamic>> getDetailsMyAcceptedTicket(
      String ticketId);

  Future<Either<Exception, dynamic>> getCurrentAcceptedTicket();

  Future<Either<Exception, dynamic>> getDropOffSchedules(
      {required int page, String? supplierId});

  Future<Either<Exception, dynamic>> getDetailsDropOffTicket(String ticketId);

  Future<Either<Exception, dynamic>> applyTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> cancelApplyTicket(
      Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> dropOffTicket(String ticketId);

  Future<Either<Exception, dynamic>> pickUp(String ticketId);

  Future<Either<Exception, dynamic>> deleteTicketNavigate(
      Map<String, dynamic> body);
}
