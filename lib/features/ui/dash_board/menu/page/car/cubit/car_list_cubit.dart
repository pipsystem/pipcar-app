import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:pipcar/features/domain/use_case/car_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../domain/enterties/car_entity.dart';
import '../../../../../../domain/enterties/car_type_entity.dart';
import '../list_car_strings.dart';

part 'car_list_state.dart';

@injectable
class CarListCubit extends BaseBloc<CarListState> {
  final CarUseCase carUseCase;
  CarListCubit(this.carUseCase) : super(CarListState.initial());

  TextEditingController nameCarController = TextEditingController();
  TextEditingController plateCarController = TextEditingController();

  @override
  void onInit() async {
    getListCar();
  }

  @override
  Future<void> close() {
    nameCarController.dispose();
    plateCarController.dispose();
    return super.close();
  }

  void onSelectedCarType(CarTypeEntity carType) {
    emit(state.copyWith(selectedCarTypeAdd: carType));
  }

  Future<void> getListCar() async {
    emit(state.copyWith(status: CarListStatus.loading));
    final result = await carUseCase.getListCar();
    result.fold(
        (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: CarListStatus.loaded, cars: right),
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
    getListCar();
  }

  Future<void> addCar() async {
    final result = await carUseCase.addCar(
      name: nameCarController.text.trim(),
      plate: plateCarController.text.trim(),
      carTypeId: state.selectedCarTypeAdd.id,
    );
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) {
        nameCarController.clear();
        plateCarController.clear();
        getIt.get<SnackbarBloc>().showSnackbar(
              translationKey: ListCarStrings.addCarSuccess,
              type: SnackBarType.success,
            );
        getListCar();
      },
    );
  }
}
