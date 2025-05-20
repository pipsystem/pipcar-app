import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/district_entity.dart';
import 'package:pipcar/features/domain/enterties/ticket/details_ticket.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';

import '../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../domain/use_case/agency_use_case.dart';

part 'add_schedule_state.dart';

@injectable
class AddScheduleCubit extends BaseBloc<AddScheduleState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  final AgencyUseCase agencyUseCase;
  DetailsPassTicket? ticketDetails;
  bool _isInited = false;
  AddScheduleCubit(this.ticketOwnerUseCase, this.agencyUseCase)
      : super(AddScheduleState.initial());

  final TextEditingController contentController = TextEditingController();
  final TextEditingController coinController = TextEditingController();
  final TextEditingController pickUpTimeController = TextEditingController();

  @override
  void onInit() {
    initializeDateFormatting();
    if(ticketDetails != null) {
      contentController.text = ticketDetails!.ticketInfor.description;
      coinController.text = ticketDetails!.ticketInfor.coin.toString();
      pickUpTimeController.text = ticketDetails!.ticketInfor.pickupTime;
      if(ticketDetails!.ticketInfor.pickupDistrictName.contains("Quận")){
        String pickupDistrictName = ticketDetails!.ticketInfor.pickupDistrictName.replaceFirst("Quận ", "");
        getListProvincePre(ticketDetails!.ticketInfor.pickupProvinceName, pickupDistrictName);
      }else{
        getListProvincePre(ticketDetails!.ticketInfor.pickupProvinceName, ticketDetails!.ticketInfor.pickupDistrictName);
      }
      selectCarType("xe ${ticketDetails!.ticketInfor.carTypeName}");
      cancelOldTicket(ticketDetails!.ticketInfor.ticketId);
    }else{
      getListProvince();
    }
  }

  @override
  Future<void> close() {
    contentController.dispose();
    coinController.dispose();
    pickUpTimeController.dispose();
    return super.close();
  }

  Future<void> cancelOldTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.cancelTicket(ticketId: ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: AddScheduleStatus.cancelOldTicketSuccessful)),
    );
  }

  void selectPickUpTime(DateTime date) {
    String formattedDate = '';
    // DateTime now = DateTime.now();
    // if (date.isAfter(now.add(const Duration(hours: 12)))) {
    formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    pickUpTimeController.text = formattedDate;
    // } else {
    //   AppUtils.showToast("Thời gian đón phải trước 12 tiếng");
    // }
  }

  void esfdsf() {
    emit(state.copyWith(status: AddScheduleStatus.createTicketSuccessful));
  }

  Future<void> createTicket() async {
    if (state.province == null) {
      AppUtils.showToast("Vui lòng chọn tỉnh thành đón");
    } else if (state.selectedDistrict == null) {
      AppUtils.showToast("Vui lòng chọn quận huyện đón");
    } else {
      final result = await ticketOwnerUseCase.createTicket(
          desciption: contentController.text.trim(),
          carTypeId: AppConstant.listCarType
              .firstWhere((e) => e.name == state.carTypeName)
              .id,
          coin: coinController.text == null ? 0: coinController.text.trim().toInt(),
          provinceId: state.province?.id.toInt() ?? 0,
          districtId: state.selectedDistrict?.id.toInt() ?? 0,
          pickUpTime: pickUpTimeController.text);

      result.fold(
          (left) =>
              getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
          (right) {
        emit(state.copyWith(status: AddScheduleStatus.createTicketSuccessful));
      });
    }
  }

  void selectCarType(String carTypeName) {
    emit(state.copyWith(carTypeName: carTypeName));
  }

  Future<void> getListProvince() async {
    final result = await agencyUseCase.getListProvince();
    result.fold((left) {}, (right) async {
      ProvinceEntity defaultProvince = (right as List<ProvinceEntity>)
          .firstWhere((e) => e.name == "Thành phố Hà Nội");
      emit(state.copyWith(provinces: right, province: defaultProvince));
      final districts = await agencyUseCase.getListDistrict(defaultProvince.id);
      districts.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) {
          var defaultDistrict = (right as List<DistrictEntity>)
              .firstWhere((e) => e.name == "Hai Bà Trưng");
          emit(state.copyWith(
              districts: right, selectedDistrict: defaultDistrict));
        },
      );
    });
  }

  Future<void> getListProvinceSearch(String name, List<ProvinceEntity> searchProvinces)async {
    searchProvinces.clear();
    final result = await agencyUseCase.getListProvinceSearch(name);
    result.fold((left) {}, (right) async {
      searchProvinces.addAll(right as List<ProvinceEntity>);
    });
  }

  Future<void> getListProvincePre(String provinceName, String districtName) async {
    final result = await agencyUseCase.getListProvince();
    result.fold((left) {}, (right) async {
      ProvinceEntity defaultProvince = (right as List<ProvinceEntity>)
          .firstWhere((e) => e.name == provinceName);
      emit(state.copyWith(provinces: right, province: defaultProvince));
      log(defaultProvince.id);
      final districts = await agencyUseCase.getListDistrict(defaultProvince.id);
      districts.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) {
          var defaultDistrict = (right as List<DistrictEntity>)
              .firstWhere((e) => e.name == districtName);
          emit(state.copyWith(
              districts: right, selectedDistrict: defaultDistrict));
        },
      );
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

  void selectProvince(ProvinceEntity provinceEntity) async {
    final result = await agencyUseCase.getListDistrict(provinceEntity.id);
    result.fold((left) {}, (right) {
      var defaultDistrict = (right as List<DistrictEntity>).first;
      emit(state.copyWith(districts: right, selectedDistrict: defaultDistrict));
    });
    emit(state.copyWith(province: provinceEntity));
  }

  void selectDistrict(DistrictEntity districtEntity) {
    emit(state.copyWith(selectedDistrict: districtEntity));
  }
}
