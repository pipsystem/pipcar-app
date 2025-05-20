import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../repository/driver_repository.dart';

@injectable
class DriverUseCase {
  final DriverRepository _repository;

  DriverUseCase(this._repository);

  Future<Either<Exception, dynamic>> getListDriver() async {
    final result = await _repository.getListDriver();
    return result;
  }

  Future<Either<Exception, dynamic>> getListDriverA4() async {
    final result = await _repository.getListDriverA4();
    return result;
  }

  Future<Either<Exception, dynamic>> getDeliveringDriver(int carTypeId) async {
    var params = {'page': 1, 'car_type_id': carTypeId, 'limit': 10000};
    final result = await _repository.getDeliveringDriver(params);
    return result;
  }

  Future<Either<Exception, dynamic>> getListCarUndeliven() async {
    final result = await _repository.getListCarUndriven();
    return result;
  }

  Future<Either<Exception, dynamic>> addDriver(
      {required String name, required String phone}) async {
    final result = await _repository.addDriver(name: name, phone: phone);
    return result;
  }

  Future<Either<Exception, dynamic>> deleteDriver(String driverId) async {
    final result = await _repository.deleteDriver(driverId);
    return result;
  }

  Future<Either<Exception, dynamic>> undeliverCar(String driverId) async {
    final result = await _repository.undeliverCar(driverId);
    return result;
  }

  Future<Either<Exception, dynamic>> deliverCar(
      {required String driverId, required String carId}) async {
    final result =
        await _repository.deliverCar(driverId: driverId, carId: carId);
    return result;
  }
}
