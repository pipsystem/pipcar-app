import 'package:either_dart/either.dart';

abstract class DriverRepository {
  Future<Either<Exception, dynamic>> getListDriver();
  
  Future<Either<Exception, dynamic>> getListDriverA4();

  Future<Either<Exception, dynamic>> getDeliveringDriver(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getListCarUndriven();

  Future<Either<Exception, dynamic>> addDriver(
      {required String name, required String phone});

  Future<Either<Exception, dynamic>> deleteDriver(String driverId);

  Future<Either<Exception, dynamic>> undeliverCar(String driverId);

  Future<Either<Exception, dynamic>> deliverCar(
      {required String driverId, required String carId});

  // Future<Either<Exception, dynamic>> addCar({
  //   required String name,
  //   required String plate,
  //   required int carTypeId,
  //   required String lat,
  //   required String long,
  // });
}
