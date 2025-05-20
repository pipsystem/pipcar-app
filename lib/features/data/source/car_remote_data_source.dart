import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../common/di/di.dart';
import '../../../common/exception/api_error.dart';
import '../../../common/local_storage/local_storage.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';
import '../../domain/enterties/car_entity.dart';
import '../mapper/mapper.dart';
import '../models/models.dart';

abstract class CarRemoteDataSource {
  Future<Either<Exception, dynamic>> getListCar();

  Future<Either<Exception, dynamic>> getListCarUndriven();

  Future<Either<Exception, dynamic>> deleteCar(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> addCar(Map<String, dynamic> body);
}

@Injectable(as: CarRemoteDataSource)
class CarRemoteDataSourceImpl extends CarRemoteDataSource with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> getListCar() {
    return call(() async {
      final result = await apiService.getListCar("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        List<CarResponse> carListResponse = CarListResponse.fromJson(data).carList;
        List<CarEntity> cars = CarMapper.fromListCarResponse(carListResponse);
        return cars;
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
        List<CarEntity> cars = CarMapper.fromCarUnderliveredResponse(carListResponse);
        return cars;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> deleteCar(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.deleteCar(body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> addCar(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.addCar(body, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
