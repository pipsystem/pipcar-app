import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/features/domain/enterties/car_entity.dart';
import 'package:pipcar/features/domain/enterties/driver_info_entity.dart';
import 'package:pipcar/features/domain/enterties/driver_location_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';
import 'package:pipcar/features/domain/use_case/driver_use_case.dart';

part 'details_driver_state.dart';

@injectable

class DetailsDriverCubit extends BaseBloc<DetailsDriverState> {
  final AgencyUseCase agencyUseCase;
  final DriverUseCase driverUseCase;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  DetailsDriverCubit(this.agencyUseCase, this.driverUseCase) : super(DetailsDriverState.init());

  @override
  void onInit() {
    
  }

  Future<void> getDetailsDriver(String agencyId) async {
    emit(state.copyWith(status: DetailsDriverStatus.loading));
    final result = await agencyUseCase.getDetailsDriverA4(agencyId);
    result.fold(
      (left) => AppUtils.showToast("Get details driver failed"),
      (right) {
        emit(state.copyWith(status: DetailsDriverStatus.loaded, driver: right));
      }
    );
  }

  Future<void> getListCar() async {
    emit(state.copyWith(status: DetailsDriverStatus.loading));
    final result = await driverUseCase.getListCarUndeliven();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: DetailsDriverStatus.loaded, cars: right),
            ));
  }

  Future<void> getLocationCar(String driverId) async {
    emit(state.copyWith(status: DetailsDriverStatus.loading));
    final result = await agencyUseCase.getDriverLocation(driverId);
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
              state.copyWith(status: DetailsDriverStatus.loaded, location: right),
            ));
  }

  void _adjustCameraZoomToFitMarkers(Set<Marker> markers) async {
    if (markers.isEmpty) return;

    LatLngBounds bounds = AppUtils.getLatLngBounds(markers);

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    (await mapController.future).animateCamera(cameraUpdate);
  }

  void updateMarker(Map<MarkerId, Marker> markers) {
    emit(state.copyWith(
        markers: markers, statusMarker: LoadMarkerStatus.loaded));
    _adjustCameraZoomToFitMarkers(Set<Marker>.of(markers.values));
  }

  void zoomToAgencySpecific(DriverLocationEntity agency) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(agency.lat.toDouble(), agency.long.toDouble()),
      zoom: 16,
    )));
  }
}