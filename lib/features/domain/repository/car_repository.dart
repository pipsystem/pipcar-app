import 'package:either_dart/either.dart';

abstract class CarRepository {
  Future<Either<Exception, dynamic>> getListCar();

  Future<Either<Exception, dynamic>> getListCarUndriven();

  Future<Either<Exception, dynamic>> deleteCar(String carId);

  Future<Either<Exception, dynamic>> addCar({
    required String name,
    required String plate,
    required int carTypeId,
    required String lat,
    required String long,
  });
}
