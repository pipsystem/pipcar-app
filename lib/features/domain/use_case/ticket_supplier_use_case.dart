import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../common/di/di.dart';
import '../../../core/presentation/bloc/loading_bloc/loading_bloc.dart';
import '../../../core/presentation/bloc/location_bloc/location_cubit.dart';
import '../repository/ticket_supplier_repository.dart';

@injectable
class TicketSupplierUseCase {
  final TicketSupplierRepository _repository;

  TicketSupplierUseCase(this._repository);

  ///System Ticket
  Future<Either<Exception, dynamic>> getNewScheduleList(
      {String? supplierId, required int page}) async {
    final result = await _repository.getNewScheduleList(
        supplierId: supplierId, page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsNewTicket(
      String ticketId) async {
    final result = await _repository.getDetailsNewTicket(ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> getApplySchedules(
      {String? supplierId, required int page}) async {
    final result =
        await _repository.getApplySchedules(supplierId: supplierId, page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsMyApplyTicket(
      String ticketId) async {
    final result = await _repository.getDetailsMyApplyTicket(ticketId);
    return result;
  }

  ///Agency's Ticket
  Future<Either<Exception, dynamic>> getMyAcceptedSchedules(
      {required int page, String? supplierId}) async {
    final result = await _repository.getMyAcceptedSchedules(
        supplierId: supplierId, page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsMyAcceptedTicket(
      String ticketId) async {
    final result = await _repository.getDetailsMyAcceptedTicket(ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> getCurrentAcceptedTicket() async {
    final result = await _repository.getCurrentAcceptedTicket();
    return result;
  }

  Future<Either<Exception, dynamic>> getDropOffSchedules(
      {required int page, String? supplierId}) async {
    final result = await _repository.getDropOffSchedules(
        supplierId: supplierId, page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsDropOffTicket(
      String ticketId) async {
    final result = await _repository.getDetailsDropOffTicket(ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> getMyCompleteSchedules(
      {required int page, String? supplierId}) async {
    final result = await _repository.getMyCompleteSchedules(
        supplierId: supplierId, page: page);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsMyCompleteTicket(
      String ticketId) async {
    final result = await _repository.getDetailsMyCompleteTicket(ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> applyTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final currentLocation = await getIt.get<LocationCubit>().getPosition();
    getIt.get<LoadingBloc>().finishLoading();
    if (currentLocation.lat != null && currentLocation.long != null) {
      var body = {
        "ticket_id": ticketId,
        "lat": currentLocation.lat.toString(),
        "long": currentLocation.long.toString(),
        // "updated_gps_time": 1694219400
      };
      final result = await _repository.applyTicket(body);
      return result;
    } else {
      return Left(Exception("Đã xảy ra lỗi khi lấy vị trí"));
    }
  }

  Future<Either<Exception, dynamic>> dropOffTicket(String ticketId) async {
    final result = await _repository.dropOffTicket(ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> pickUp(String ticketId) async {
    final result = await _repository.pickUp(ticketId);
    return result;
  }

  Future<Either<Exception, dynamic>> deleteTicketNavigate(
      String ticketId) async {
    var body = {'ticket_id': ticketId};
    final result = await _repository.deleteTicketNavigate(body);
    return result;
  }

  Future<Either<Exception, dynamic>> cancelApplyTicket(String ticketId) async {
    var body = {'ticket_id': ticketId};
    final result = await _repository.cancelApplyTicket(body);
    return result;
  }
}
