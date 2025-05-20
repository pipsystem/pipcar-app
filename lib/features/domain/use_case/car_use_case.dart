import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pipcar/core/presentation/bloc/location_bloc/location_cubit.dart';

import '../../../common/di/di.dart';
import '../repository/car_repository.dart';

@injectable
class CarUseCase {
  final CarRepository _repository;

  CarUseCase(this._repository);

  Future<Either<Exception, dynamic>> getListCar() async {
    final result = await _repository.getListCar();
    return result;
  }

  Future<Either<Exception, dynamic>> getListCarUndriven() async {
    final result = await _repository.getListCarUndriven();
    return result;
  }

  Future<Either<Exception, dynamic>> deleteCar(String carId) async {
    final result = await _repository.deleteCar(carId);
    return result;
  }

  Future<Either<Exception, dynamic>> addCar(
      {required String name, required String plate, required int carTypeId}) async {
    getIt.get<LoadingBloc>().startLoading();
    final currentLocation = await getIt.get<LocationCubit>().getPosition();
    getIt.get<LoadingBloc>().finishLoading();
    if (currentLocation.lat != null && currentLocation.long != null) {
      final result = await _repository.addCar(
        name: name,
        plate: plate,
        carTypeId: carTypeId,
        lat: currentLocation.lat.toString(),
        long: currentLocation.long.toString(),
      );
      return result;
    } else {
      return Left(Exception("Đã xảy ra lỗi khi lấy vị trí"));
    }
  }
}
