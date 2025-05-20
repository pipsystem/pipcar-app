import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/data/mapper/ticket_supplier_mapper.dart';
import 'package:pipcar/features/data/models/models.dart';
import 'package:pipcar/features/data/models/ticket_supplier/supplier_current_accepted_ticket_response.dart';

import 'package:pipcar/features/data/models/ticket_supplier/supplier_new_ticket_details_response.dart';
import 'package:pipcar/features/data/models/ticket_supplier/supplier_tickets_apply_response.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';

import '../../../common/di/di.dart';
import '../../../common/exception/api_error.dart';
import '../../../common/local_storage/local_storage.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';

abstract class TicketSupplierRemoteDataSource {
  Future<Either<Exception, dynamic>> getNewSchedule(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsNewTicket(String ticketId);

  Future<Either<Exception, dynamic>> getApplySchedules(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsMyApplyTicket(String ticketId);

  Future<Either<Exception, dynamic>> getMyCompleteSchedules(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsMyCompleteTicket(
      String ticketId);

  Future<Either<Exception, dynamic>> getMyAcceptedSchedules(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsMyAcceptedTicket(
      String ticketId);

  Future<Either<Exception, dynamic>> getCurrentAcceptedTicket();

  Future<Either<Exception, dynamic>> getDetailsDropOffTicket(String ticketId);

  Future<Either<Exception, dynamic>> getDropOffSchedules(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> applyTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> cancelApplyTicket(
      Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> dropOffTicket(String ticketId);

  Future<Either<Exception, dynamic>> pickUp(String ticketId);

  Future<Either<Exception, dynamic>> deleteTicketNavigate(
      Map<String, dynamic> body);
}

@Injectable(as: TicketSupplierRemoteDataSource)
class TicketSupplierDataSourceImpl extends TicketSupplierRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> getNewSchedule(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getNewSchedule(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierListTicketResponse listResponse =
            SupplierListTicketResponse.fromJson(data);
        List<TicketSupplierEntity> newTickets =
            (listResponse.supplierNewList ?? [])
                .map((e) => TicketSupplierMapper.fromSupplierTicket(e))
                .toList();
        return newTickets;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsNewTicket(String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsNewTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierNewTicketDetailsResponse response =
            SupplierNewTicketDetailsResponse.fromJson(data);
        TicketSupplierDetails detailsNewTicket =
            TicketSupplierMapper.converTicketSupplierDetails(response);
        return detailsNewTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getApplySchedules(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getTicketsApply(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierTicketsApplyResponse listResponse =
            SupplierTicketsApplyResponse.fromJson(data);
        List<TicketSupplierEntity> ticketsApply =
            (listResponse.supplierApplyList ?? [])
                .map((e) => TicketSupplierMapper.fromSupplierTicket(e))
                .toList();
        return ticketsApply;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsMyApplyTicket(String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsApplyTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierNewTicketDetailsResponse response =
            SupplierNewTicketDetailsResponse.fromJson(data);
        TicketSupplierDetails detailsNewTicket =
            TicketSupplierMapper.converTicketSupplierDetails(response);
        return detailsNewTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getMyCompleteSchedules(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getMyCompleteSchedules(
          params, "Bearer ${LocalStorage.accessToken.val}");

      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierCompleteTicketsResponse listResponse =
            SupplierCompleteTicketsResponse.fromJson(data);
        List<TicketSupplierEntity> ticketsComplete =
            (listResponse.supplierCompleteList ?? [])
                .map((e) => TicketSupplierMapper.fromSupplierTicket(e))
                .toList();
        return ticketsComplete;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsMyCompleteTicket(
      String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsMyCompleteTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierNewTicketDetailsResponse response =
            SupplierNewTicketDetailsResponse.fromJson(data);
        TicketSupplierDetails detailsNewTicket =
            TicketSupplierMapper.converTicketSupplierDetails(response);
        return detailsNewTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getMyAcceptedSchedules(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getMyAcceptedSchedules(
          params, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierAcceptedTicketsResponse listResponse =
            SupplierAcceptedTicketsResponse.fromJson(data);
        List<TicketSupplierEntity> ticketsAccepted =
            (listResponse.supplierAcceptedList ?? [])
                .map((e) => TicketSupplierMapper.fromSupplierTicket(e))
                .toList();
        return ticketsAccepted;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsMyAcceptedTicket(
      String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsMyAcceptedTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierNewTicketDetailsResponse response =
            SupplierNewTicketDetailsResponse.fromJson(data);
        TicketSupplierDetails detailsNewTicket =
            TicketSupplierMapper.converTicketSupplierDetails(response);
        return detailsNewTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
  @override
  Future<Either<Exception, dynamic>> getCurrentAcceptedTicket(){
    return call(() async {
      final result = await apiService.getCurrentAcceptedTicket("Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierCurentAcceptedTicketsResponse response = SupplierCurentAcceptedTicketsResponse.fromJson(data);
        return response;
      }else{
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDropOffSchedules(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getDropOffSchedules(
          params, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierDropOffTicketsResponse listResponse =
            SupplierDropOffTicketsResponse.fromJson(data);
        List<TicketSupplierEntity> ticketsDropOff =
            (listResponse.supplierDropOffList ?? [])
                .map((e) => TicketSupplierMapper.fromSupplierTicket(e))
                .toList();
        return ticketsDropOff;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsDropOffTicket(String ticketId) {
    return call(() async {
      print(ticketId);
      final result = await apiService.getDetailsDropOffTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());

      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        SupplierNewTicketDetailsResponse response =
            SupplierNewTicketDetailsResponse.fromJson(data);
        TicketSupplierDetails detailsNewTicket =
            TicketSupplierMapper.converTicketSupplierDetails(response);
        return detailsNewTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> applyTicket(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.applyTicket(
          body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> cancelApplyTicket(
      Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.cancelApplyTicket(
          body, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> dropOffTicket(String ticketId) {
    return call(() async {
      final result = await apiService.dropOff(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> pickUp(String ticketId) {
    return call(() async {
      final result = await apiService.pickUp(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> deleteTicketNavigate(
      Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.deleteTicketNavigate(
          body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
