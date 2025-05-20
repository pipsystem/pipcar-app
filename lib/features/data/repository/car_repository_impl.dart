import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/car_repository.dart';
import '../source/car_remote_data_source.dart';

@Injectable(as: CarRepository)
class CarRepositoryImpl extends CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> getListCar() async {
    final result = await remoteDataSource.getListCar();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListCarUndriven() async {
    final result = await remoteDataSource.getListCarUndriven();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> deleteCar(String carId) async {
    var body = {"car_id": carId};
    final result = await remoteDataSource.deleteCar(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> addCar({
    required String name,
    required String plate,
    required int carTypeId,
    required String lat,
    required String long,
  }) async {
    var body = {
      "plates": plate,
      "car_type_id": carTypeId,
      "name": name,
      "lat": lat,
      "long": long,
    };
    final result = await remoteDataSource.addCar(body);
    return result;
  }
}
