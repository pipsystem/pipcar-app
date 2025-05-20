import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/data/models/driver/driver_delivering_response.dart';
import 'package:pipcar/features/domain/enterties/agency/driver_item_list_entity.dart';

import '../../../common/di/di.dart';
import '../../../common/exception/api_error.dart';
import '../../../common/local_storage/local_storage.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';
import '../../domain/enterties/car_entity.dart';
import '../mapper/mapper.dart';
import '../models/models.dart';

abstract class DriverRemoteDataSource {
  Future<Either<Exception, dynamic>> getListDriver();

  Future<Either<Exception, dynamic>> getListDriverA4();

  Future<Either<Exception, dynamic>> getListCarUndriven();

  Future<Either<Exception, dynamic>> addDriver(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> deleteDriver(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> undeliverCar(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> deliverCar(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> getListDriverDelivering(
      Map<String, dynamic> params);
}

@Injectable(as: DriverRemoteDataSource)
class DriverRemoteDataSourceImpl extends DriverRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> getListDriver() {
    return call(() async {
      final result = await apiService
          .getListDriver("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        DriverListResponse driversResponse = DriverListResponse.fromJson(data);
        List<DriverItemListEntity> drivers =
            DriverMapper.fromListDriverResponse(driversResponse);
        return drivers;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getListDriverA4() {
    return call(() async {
      final result = await apiService
          .getListDriverA4("Bearer ${LocalStorage.accessToken.val}");
      print(result);
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        DriverListResponse driversResponse = DriverListResponse.fromJson(data);
        List<DriverItemListEntity> drivers =
            DriverMapper.fromListDriverResponse(driversResponse);
        return drivers;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getListCarUndriven() {
    return call(() async {
      final result = await apiService
          .getListCarUndriven("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        List<CarResponse> carListResponse =
            CarListResponse.fromJson(data).carList;
        List<CarEntity> cars = CarMapper.fromListCarResponse(carListResponse);
        return cars;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> addDriver(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.addDriver(
          body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> deleteDriver(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.deleteDriver(
          body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> undeliverCar(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.undeliverCar(
          body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> deliverCar(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.deliverCar(
          body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getListDriverDelivering(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.driverDelivering(
          params, "Bearer ${LocalStorage.accessToken.val}");
      print(result);
      if (result.status == RemoteDataContants.successStatus) {
        final listDriver = ListDeliveringResponse.fromJson(result.data);
        return DriverMapper.converDriverDelivering(listDriver);
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
