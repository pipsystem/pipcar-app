import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/ticket_owner_repository.dart';
import '../source/ticket_owner_remote_data_source.dart';

@Injectable(as: TicketOwnerRepository)
class TicketOwnerRepositoryImpl extends TicketOwnerRepository {
  final TicketOwnerRemoteDataSource remoteDataSource;

  TicketOwnerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> createTicket({
    required String desciption,
    required int carTypeId,
    required int coin,
    required int provinceId,
    required int districtId,
    required String pickUpTime,
  }) async {
    final body = {
      "description": desciption,
      "car_type_id": carTypeId,
      "coin": coin,
      "pickup_province": provinceId,
      "pickup_district": districtId,
      "pickup_time": pickUpTime
    };
    final result = await remoteDataSource.createTicket(body);
    return result;
  }

  @override
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
    final body = {
      "description": desciption,
      'supplier_id': supplierId,
      "car_type_id": carTypeId,
      "pickup_province": provincePickId,
      "pickup_district": districtPickId,
      "pickup_time": pickUpTime,
      "dropoff_province": provinceDropId,
      "dropoff_district": districtDropId,
      "dropoff_time": dropOffTime
    };
    final result = await remoteDataSource.createTicketNavigate(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getPassList({required int page}) async {
    final params = {'page': page, 'limit': 5};
    final result = await remoteDataSource.getPassList(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getAcceptedList(
      {required int page}) async {
    final params = {'page': page, 'limit': 5};
    final result = await remoteDataSource.getAcceptedList(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getCompleteList(
      {required int page}) async {
    final params = {'page': page, 'limit': 5};
    final result = await remoteDataSource.getCompleteList(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getProcessList(
      {required int page}) async {
    final params = {'page': page, 'limit': 5};
    final result = await remoteDataSource.getProcessList(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsPassTicket(
      {required String ticketId}) async {
    final result = await remoteDataSource.getDetailsPassTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsAcceptedTicket(
      {required String ticketId}) async {
    final result = await remoteDataSource.getDetailsAcceptedTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsCompleteTicket(
      {required String ticketId}) async {
    final result = await remoteDataSource.getDetailsCompleteTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsProcessTicket(
      {required String ticketId}) async {
    final result = await remoteDataSource.getDetailsProcessTicket(ticketId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> cancelTicket(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.cancelTicket(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> acceptTicket(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.acceptTicket(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> completeTicket(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.completeTicket(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> updateTicketCustomer(
      Map<String, dynamic> body) async {
    final result = await remoteDataSource.updateTicketCustomer(body);
    return result;
  }
}
