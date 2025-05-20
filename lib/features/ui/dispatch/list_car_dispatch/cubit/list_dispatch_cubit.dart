// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/dispatch/analyst_angency_entity.dart';
import 'package:pipcar/features/domain/enterties/dispatch/driver_delivering_entity.dart';
import 'package:pipcar/features/domain/use_case/car_use_case.dart';
import 'package:pipcar/features/domain/use_case/driver_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../domain/enterties/entities.dart';
import '../../../../domain/use_case/agency_use_case.dart';

part 'list_dispatch_state.dart';

@injectable
class ListDispatchCubit extends BaseBloc<ListDispatchState> {
  final DriverUseCase driverUseCase;
  final CarUseCase carUserCase;
  final AgencyUseCase agencyUseCase;
  ListDispatchCubit(
    this.driverUseCase,
    this.carUserCase,
    this.agencyUseCase,
  ) : super(ListDispatchState.initial());

  @override
  void onInit() {
    getListCar();
    getListDriver();
    getInforAnalystic();
  }

  Future<void> getInforAnalystic() async {
    final result = await agencyUseCase.getAgencyInforAnalyst();
    result.fold(
      (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) {
        emit(
          state.copyWith(inforAnalyst: right),
        );
      },
    );
  }

  // Future<void> getListDriver({int? carTypeId}) async {
  //   emit(state.copyWith(status: ListDispatchStatus.loading));
  //   final result = await driverUseCase
  //       .getDeliveringDriver(carTypeId ?? state.selectedCarType.id);
  //   result.fold(
  //     (left) =>
  //         getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
  //     (right) {
  //       var listDispatch = (right as List<DriverDeleveringEntity>);
  //       emit(
  //         state.copyWith(
  //             status: ListDispatchStatus.loaded, driversDelevering: listDispatch),
  //       );
  //     },
  //   );
  // }

  Future<void> getListDriver() async {
    emit(state.copyWith(status: ListDispatchStatus.loading));
    final result = await driverUseCase.getListDriverA4();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: ListDispatchStatus.loaded, drivers: right),
            ));
  }

  Future<void> getListCar() async {
    emit(state.copyWith(status: ListDispatchStatus.loading));
    final result = await driverUseCase.getListCarUndeliven();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: ListDispatchStatus.loaded, cars: right),
            ));
  }

  Future<void> putDeliverCar(String driverId, String carId) async {
    final result = await driverUseCase.deliverCar(driverId: driverId, carId: carId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: ListDispatchStatus.dispatchSuccess))
    );
  }

  Future<void> putUnDeliverCar(String driverId) async {
    final result = await driverUseCase.undeliverCar(driverId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: ListDispatchStatus.canceled))
    );
  }
}
