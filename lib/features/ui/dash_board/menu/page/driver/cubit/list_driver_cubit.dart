import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_infor_entity.dart';
import 'package:pipcar/features/domain/enterties/agency/driver_item_list_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';
import 'package:pipcar/features/domain/use_case/driver_use_case.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/driver/list_driver_strings.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';

part 'list_driver_state.dart';

@injectable
class ListDriverCubit extends BaseBloc<ListDriverState> {
  final AgencyUseCase agencyUseCase;
  final DriverUseCase driverUseCase;
  ListDriverCubit(this.driverUseCase, this.agencyUseCase) : super(ListDriverState.initial());

  TextEditingController nameDriverController = TextEditingController();
  TextEditingController phoneDriverController = TextEditingController();

  @override
  void onInit() async {
    final result = await agencyUseCase.getAgencyInfor();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
            state.copyWith(agencyInfor: right)));
    getListDriver();
  }

  @override
  Future<void> close() {
    nameDriverController.dispose();
    phoneDriverController.dispose();
    return super.close();
  }

  Future<void> getListDriver() async {
    emit(state.copyWith(status: ListDriverStatus.loading));
    final result = await driverUseCase.getListDriver();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: ListDriverStatus.loaded, drivers: right),
            ));
  }

  Future<void> deleteDriver(String driverId) async {
    final result = await driverUseCase.deleteDriver(driverId);
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => getIt.get<SnackbarBloc>().showSnackbar(
              translationKey: ListDriverStrings.deleteDriverSuccess,
              type: SnackBarType.success,
            ));
    getListDriver();
  }

  Future<void> addDriver() async {
    final result = await driverUseCase.addDriver(
      name: nameDriverController.text.trim(),
      phone: phoneDriverController.text.trim(),
    );
    result.fold(
      (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) {
        nameDriverController.clear();
        phoneDriverController.clear();
        getIt.get<SnackbarBloc>().showSnackbar(
              translationKey: ListDriverStrings.addDriverSuccess,
              type: SnackBarType.success,
            );
        getListDriver();
      },
    );
  }

  Future<void> undeliverCar(String driverId) async {
    getIt.get<DialogBloc>().showOptionDialog(
        message: ListDriverStrings.cofirmUnDelivery,
        acceptAction: () async {
          final result = await driverUseCase.undeliverCar(driverId);
          result.fold(
            (left) => getIt
                .get<DialogBloc>()
                .showAlertDialog(message: left.toString()),
            (right) {
              getIt.get<SnackbarBloc>().showSnackbar(
                    translationKey: ListDriverStrings.unDeliverySuccess,
                    type: SnackBarType.success,
                  );
              getListDriver();
            },
          );
        });
  }
}
