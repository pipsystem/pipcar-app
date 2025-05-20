import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/ticket_supplier_repository.dart';
import '../source/ticket_supplier_remote_data_source.dart';

@Injectable(as: TicketSupplierRepository)
class TicketSupplierRepositoryImpl extends TicketSupplierRepository {
  final TicketSupplierRemoteDataSource remoteDataSource;

  TicketSupplierRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> getNewScheduleList(
      {String? supplierId, required int page}) async {
    final Map<String, dynamic> params = {'page': page, 'limit': 5};
    if (supplierId != null) params['supplier_id'] = supplierId;
    final result = await remoteDataSource.getNewSchedule(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsNewTicket(
      String ticketId) async {
    final result = await remoteDataSource.getDetailsNewTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getApplySchedules(
      {String? supplierId, required int page}) async {
    final Map<String, dynamic> params = {'page': page, 'limit': 5};
    if (supplierId != null) params['supplier_id'] = supplierId;
    final result = await remoteDataSource.getApplySchedules(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsMyApplyTicket(
      String ticketId) async {
    final result = await remoteDataSource.getDetailsMyApplyTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getMyAcceptedSchedules(
      {required int page, String? supplierId}) async {
    final Map<String, dynamic> params = {'page': page, 'limit': 5};
    if (supplierId != null) params['supplier_id'] = supplierId;
    final result = await remoteDataSource.getMyAcceptedSchedules(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsMyAcceptedTicket(
      String ticketId) async {
    final result = await remoteDataSource.getDetailsMyAcceptedTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDropOffSchedules(
      {required int page, String? supplierId}) async {
    final Map<String, dynamic> params = {'page': page, 'limit': 5};
    if (supplierId != null) params['supplier_id'] = supplierId;
    final result = await remoteDataSource.getDropOffSchedules(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsDropOffTicket(
      String ticketId) async {
    final result = await remoteDataSource.getDetailsDropOffTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getMyCompleteSchedules(
      {required int page, String? supplierId}) async {
    final Map<String, dynamic> params = {'page': page, 'limit': 5};
    if (supplierId != null) params['supplier_id'] = supplierId;
    final result = await remoteDataSource.getMyCompleteSchedules(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsMyCompleteTicket(
      String ticketId) async {
    final result = await remoteDataSource.getDetailsMyCompleteTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getCurrentAcceptedTicket() async {
    final result = await remoteDataSource.getCurrentAcceptedTicket();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> applyTicket(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.applyTicket(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> dropOffTicket(String ticketId) async {
    final result = await remoteDataSource.dropOffTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> cancelApplyTicket(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.cancelApplyTicket(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> pickUp(String ticketId) async {
    final result = await remoteDataSource.pickUp(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> deleteTicketNavigate(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.deleteTicketNavigate(body);
    return result;
  }
}
