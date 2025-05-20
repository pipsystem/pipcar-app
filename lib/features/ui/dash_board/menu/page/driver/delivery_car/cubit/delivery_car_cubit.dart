import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pipcar/features/domain/enterties/car_entity.dart';
import 'package:pipcar/features/domain/use_case/car_use_case.dart';
import 'package:pipcar/features/domain/use_case/driver_use_case.dart';

import '../../../../../../../../common/di/di.dart';
import '../../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import '../../../car/list_car_strings.dart';

part 'delivery_car_state.dart';

@injectable
class DeliveryCarCubit extends BaseBloc<DeliveryCarState> {
  final DriverUseCase driverUseCase;
  final CarUseCase carUseCase;
  DeliveryCarCubit(this.driverUseCase, this.carUseCase) : super(DeliveryCarState.initial());

  @override
  void onInit() {
    getListCarUndelivery();
  }

  Future<void> getListCarUndelivery() async {
    emit(state.copyWith(status: DeliveryCarStatus.loading));
    final result = await driverUseCase.getListCarUndeliven();
    result.fold(
        (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: DeliveryCarStatus.loaded, cars: right),
            ));
  }

  Future<void> deleteCar(String carId) async {
    final result = await carUseCase.deleteCar(carId);
    result.fold(
        (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => getIt.get<SnackbarBloc>().showSnackbar(
              translationKey: ListCarStrings.deleteCarSuccess,
              type: SnackBarType.success,
            ));
    getListCarUndelivery();
  }

  Future<Either<Exception, dynamic>> deliverCar(String driverId, String carId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await driverUseCase.deliverCar(driverId: driverId, carId: carId);
    getIt.get<LoadingBloc>().finishLoading();
    return result;
  }
}
