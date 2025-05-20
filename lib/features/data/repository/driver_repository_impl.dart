import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/driver_repository.dart';
import '../source/driver_remote_data_source.dart';

@Injectable(as: DriverRepository)
class DriverRepositoryImpl extends DriverRepository {
  final DriverRemoteDataSource remoteDataSource;

  DriverRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> getListDriver() async {
    final result = await remoteDataSource.getListDriver();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListDriverA4() async {
    final result = await remoteDataSource.getListDriverA4();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDeliveringDriver(
      Map<String, dynamic> params) async {
    final result = await remoteDataSource.getListDriverDelivering(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListCarUndriven() async {
    final result = await remoteDataSource.getListCarUndriven();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> addDriver(
      {required String name, required String phone}) async {
    var body = {"name": name, "phone": phone};
    final result = await remoteDataSource.addDriver(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> deleteDriver(String driverId) async {
    var body = {"driver_id": driverId};
    final result = await remoteDataSource.deleteDriver(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> undeliverCar(String driverId) async {
    var body = {"driver_id": driverId};
    final result = await remoteDataSource.undeliverCar(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> deliverCar(
      {required String driverId, required String carId}) async {
    var body = {"driver_id": driverId, "car_id": carId};
    final result = await remoteDataSource.deliverCar(body);
    return result;
  }
}
