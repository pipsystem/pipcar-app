import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pipcar/core/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_search_infor_entity.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';

import '../../../../../common/assets/assets.gen.dart';
import '../../../../../common/di/di.dart';
import '../../../../../common/utils/utils_src.dart';
import '../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';
import '../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends BaseBloc<SearchState> {
  final AgencyUseCase agencyUseCase;
  SearchCubit(this.agencyUseCase) : super(SearchState.initial());

  TextEditingController pickUpTimeController = TextEditingController();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  late BitmapDescriptor markerIcon;

  @override
  void onInit() async {
    await getListProvince();
    await getListDistrict(state.selectedProvince?.id ?? "27");
    markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      Assets.images.icMarker.keyName,
    );
    initializeDateFormatting();
    emit(state.copyWith(status: SearchStatus.loading));
    setDefaultPickUptime();
    resetConfigs();
    getListAgencySearch();
  }

  @override
  Future<void> close() async {
    (await mapController.future).dispose();
    pickUpTimeController.dispose();
    return super.close();
  }

  Future<void> getListProvince() async {
    final result = await agencyUseCase.getListProvince();
    result.fold((left) {}, (right) {
      var defaultProvince = (right as List<ProvinceEntity>)
          .firstWhere((e) => e.name == "Thành phố Hà Nội");
      emit(state.copyWith(provinces: right, selectedProvince: defaultProvince));
    });
  }

  Future<void> getListProvinceSearch(String name, List<ProvinceEntity> searchProvinces)async {
    searchProvinces.clear();
    final result = await agencyUseCase.getListProvinceSearch(name);
    result.fold((left) {}, (right) async {
      searchProvinces.addAll(right as List<ProvinceEntity>);
    });
  }

  Future<void> getListDistrict(String provinceId) async {
    final result = await agencyUseCase.getListDistrict(provinceId);
    result.fold((left) {}, (right) {
      var defaultDistrict = (right as List<DistrictEntity>).first;
      emit(state.copyWith(districts: right, selectedDistrict: defaultDistrict));
    });
  }

  Future<void> getListDistrictSearch(String provinceId, String name, List<DistrictEntity> searchDistricts) async {
    searchDistricts.clear();
    final result = await agencyUseCase.getListDistrictSearch(provinceId, name);
    result.fold((left) {}, (right) {
      searchDistricts.addAll(right as List<DistrictEntity>);
    });
  }

  Future<void> getListAgencySearch() async {
    final result = await agencyUseCase.getListAgencySearch(
        districtId: state.selectedDistrictConfig!.id.toInt(),
        provinceId: state.selectedProvinceConfig!.id,
        carTypeId: state.carTypeEntity.id,
        pickUpTime: pickUpTimeController.text);

    result.fold((left) {}, (right) async {
      emit(state.copyWith(
          agencies: right,
          selectedDistrict: state.selectedDistrictConfig,
          selectedProvince: state.selectedProvinceConfig,
          status: SearchStatus.loaded,
          statusMarker: LoadMarkerStatus.loading));
    });
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

  void zoomToAgencySpecific(AgencySearchEntity agency) async {
    GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(agency.carLat.toDouble(), agency.carLong.toDouble()),
      zoom: 16,
    )));
  }

  Future<void> selectCarType(CarTypeEntity carType) async {
    emit(state.copyWith(carTypeEntity: carType));
    final result = await agencyUseCase.getListAgencySearch(
        districtId: state.selectedDistrict!.id.toInt(),
        provinceId: state.selectedProvinceConfig!.id,
        carTypeId: state.carTypeEntity.id,
        pickUpTime: pickUpTimeController.text);
    result.fold((left) {}, (right) async {
      emit(state.copyWith(
        agencies: right,
        statusMarker: LoadMarkerStatus.loading,
      ));
    });
  }

  void selectPickUpTime(DateTime date) {
    String formattedDate = '';
    formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    pickUpTimeController.text = formattedDate;
  }

  void setDefaultPickUptime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('HH:mm dd/MM/yyyy').format(now.add(const Duration(days: 2)));
    pickUpTimeController.text = formattedDate;
  }

  void selectDistrict(DistrictEntity districtEntity) {
    emit(state.copyWith(selectedDistrictConfig: districtEntity));
  }

  void selectProvince(ProvinceEntity provinceEntity) async {
    final result = await agencyUseCase.getListDistrict(provinceEntity.id);
    result.fold((left) {}, (right) {
      var defaultDistrict = (right as List<DistrictEntity>).first;
      emit(state.copyWith(
          districts: right, selectedDistrictConfig: defaultDistrict));
    });
    emit(state.copyWith(selectedProvinceConfig: provinceEntity));
  }

  void resetConfigs() {
    emit(state.copyWith(selectedDistrictConfig: state.selectedDistrict));
    emit(state.copyWith(selectedProvinceConfig: state.selectedProvince));
    getListDistrict(state.selectedProvince?.id ?? "27");
  }

  Future<void> getAgencySearchInfor() async {
    getIt.get<LoadingBloc>().startLoading();
    List<AgencySearchInforEntity> oldList = [];
    for(AgencySearchEntity agencySearchEntity in state.agencies){
    final result = await agencyUseCase.getAgencySearchInfor(
        agencyId: agencySearchEntity.agencyId, carId: agencySearchEntity.id);
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) {
      // FlutterPhoneDirectCaller.callNumber(right);
            oldList.add(right as AgencySearchInforEntity);
    });
    }
    emit(state.copyWith(agencySearchInforList: oldList));
  }

  Future<void> getPhoneAgency(AgencySearchEntity agencySearchEntity) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await agencyUseCase.getPhoneAgency(
        agencyId: agencySearchEntity.agencyId, carId: agencySearchEntity.id);
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) {
      FlutterPhoneDirectCaller.callNumber(right);
    });
  }

}
