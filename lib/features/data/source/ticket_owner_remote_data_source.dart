import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/data/mapper/ticket_mapper.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_owner_process.dart';

import '../../../common/di/di.dart';
import '../../../common/exception/api_error.dart';
import '../../../common/local_storage/local_storage.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';
import '../../domain/enterties/entities.dart';
import '../models/models.dart';
import '../models/ticket_owner/owner_complete_list_response.dart';
import '../models/ticket_owner/ticket_details_response.dart';

abstract class TicketOwnerRemoteDataSource {
  Future<Either<Exception, dynamic>> createTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> createTicketNavigate(
      Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> getPassList(Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getAcceptedList(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getCompleteList(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getProcessList(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsPassTicket(String ticketId);

  Future<Either<Exception, dynamic>> getDetailsAcceptedTicket(String ticketId);

  Future<Either<Exception, dynamic>> getDetailsCompleteTicket(String ticketId);
  
  Future<Either<Exception, dynamic>> getDetailsProcessTicket(String ticketId);

  Future<Either<Exception, dynamic>> cancelTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> acceptTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> completeTicket(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> updateTicketCustomer(
      Map<String, dynamic> body);
}

@Injectable(as: TicketOwnerRemoteDataSource)
class TicketOwnerDataSourceImpl extends TicketOwnerRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> createTicket(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.createTicket(
          body, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> createTicketNavigate(
      Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.createTicketNavigate(
          body, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> getPassList(Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getPassList(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        OwnerPassListResponse listResponse =
            OwnerPassListResponse.fromJson(data);
        List<TicketOwnerPassEntity> passList =
            (listResponse.ownerPassList ?? [])
                .map((e) => TicketMapper.fromOwnerTicketResponse(e))
                .toList();
        return passList;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getAcceptedList(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getAcceptedList(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        OwnerAcceptedListResponse listResponse =
            OwnerAcceptedListResponse.fromJson(data);
        List<TicketOwnerAcceptedEntity> acceptedList =
            (listResponse.ownerAcceptedList ?? [])
                .map((e) => TicketMapper.fromOwnerAcceptedResponse(e))
                .toList();
        return acceptedList;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getCompleteList(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getCompleteList(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        OwnerCompleteListResponse listResponse =
            OwnerCompleteListResponse.fromJson(data);
        List<TicketOwnerCompleteEntity> completeList =
            (listResponse.ownerCompleteList ?? [])
                .map((e) => TicketMapper.fromOwnerCompleteResponse(e))
                .toList();
        return completeList;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getProcessList(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getProcessList(
          params, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        OwnerProcessListResponse listResponse =
            OwnerProcessListResponse.fromJson(data);
        List<TicketOwnerProcessEntity> processList =
            (listResponse.ownerProcessList ?? [])
                .map((e) => TicketMapper.fromOwnerProcessResponse(e))
                .toList();
        return processList;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsPassTicket(String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsPassTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        TicketDetailsResponse response = TicketDetailsResponse.fromJson(data);
        DetailsPassTicket detailsPassTicket =
            TicketMapper.fromDetailsPassResponse(response);
        return detailsPassTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsAcceptedTicket(String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsAcceptedTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        TicketDetailsResponse response = TicketDetailsResponse.fromJson(data);
        DetailsAcceptedTicket detailsAcceptedTicket =
            TicketMapper.fromDetailsAcceptedResponse(response);
        return detailsAcceptedTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsCompleteTicket(String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsCompleteTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        TicketDetailsResponse response = TicketDetailsResponse.fromJson(data);
        DetailsAcceptedTicket detailsAcceptedTicket =
            TicketMapper.fromDetailsAcceptedResponse(response);
        return detailsAcceptedTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsProcessTicket(String ticketId) {
    return call(() async {
      final result = await apiService.getDetailsProcessTicket(
          ticketId, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        TicketDetailsResponse response = TicketDetailsResponse.fromJson(data);
        DetailsProcessTicket detailsPassTicket =
            TicketMapper.fromDetailsProcessResponse(response);
        return detailsPassTicket;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> acceptTicket(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.acceptTicket(
          body, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> cancelTicket(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.cancelTicket(
          body, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> completeTicket(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.completeTicket(
          body, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> updateTicketCustomer(
      Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.updateTicketCustomer(
          body, "Bearer ${LocalStorage.accessToken.val}");
      log(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
