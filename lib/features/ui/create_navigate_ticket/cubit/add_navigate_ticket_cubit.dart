import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/district_entity.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';

import '../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../domain/use_case/agency_use_case.dart';

part 'add_navigate_ticket_state.dart';

@injectable
class AddNavigateTicketCubit extends BaseBloc<AddNavigateState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  final AgencyUseCase agencyUseCase;
  AddNavigateTicketCubit(this.ticketOwnerUseCase, this.agencyUseCase)
      : super(AddNavigateState.initial());

  final TextEditingController contentController = TextEditingController();
  final TextEditingController pickUpTimeController = TextEditingController();
  final TextEditingController dropOffTimeController = TextEditingController();

  @override
  void onInit() {
    initializeDateFormatting();
    getListProvince();
  }

  @override
  Future<void> close() {
    contentController.dispose();
    pickUpTimeController.dispose();
    dropOffTimeController.dispose();
    return super.close();
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

  void selectDropOffTime(DateTime date) {
    String formattedDate = '';
    // DateTime now = DateTime.now();
    // if (date.isAfter(now.add(const Duration(hours: 12)))) {
    formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    dropOffTimeController.text = formattedDate;
    // } else {
    //   AppUtils.showToast("Thời gian đón phải trước 12 tiếng");
    // }
  }

  Future<void> createTicketNavigate(
      {required String supplierId, int? carTypeId}) async {
    if (state.provincePick == null) {
      AppUtils.showToast("Vui lòng chọn tỉnh thành đón");
    } else if (state.districtPick == null) {
      AppUtils.showToast("Vui lòng chọn quận huyện đón");
    } else {
      final result = await ticketOwnerUseCase.createTicketNavigate(
          supplierId: supplierId,
          desciption: contentController.text.trim(),
          provincePickId: state.provincePick?.id.toInt() ?? 0,
          districtPickId: state.districtPick?.id.toInt() ?? 0,
          provinceDropId: state.provinceDrop?.id.toInt() ?? 0,
          districtDropId: state.districtDrop?.id.toInt() ?? 0,
          dropOffTime: dropOffTimeController.text,
          pickUpTime: pickUpTimeController.text,
          carTypeId: carTypeId ?? LocalStorage.carTypeId.val);

      result.fold(
          (left) =>
              getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
          (right) {
        emit(state.copyWith(status: AddNavigateStatus.createTicketSuccessful));
      });
    }
  }

  Future<void> getListProvince() async {
    final result = await agencyUseCase.getListProvince();
    result.fold((left) {}, (right) async {
      ProvinceEntity defaultProvince = (right as List<ProvinceEntity>)
          .firstWhere((e) => e.name == "Thành phố Hà Nội");
      emit(state.copyWith(
          provinces: right,
          provincePick: defaultProvince,
          provinceDrop: defaultProvince));
      final districts = await agencyUseCase.getListDistrict(defaultProvince.id);
      districts.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) {
          var defaultDistrict = (right as List<DistrictEntity>)
              .firstWhere((e) => e.name == "Hai Bà Trưng");
          emit(state.copyWith(
              districtsPickList: right,
              districtsDropList: right,
              districtPick: defaultDistrict,
              districtDrop: defaultDistrict));
        },
      );
    });
  }

  // Future<void> getListDistrict(String provinceId) async {
  //   final result = await agencyUseCase.getListDistrict(provinceId);
  //   result.fold((left) {}, (right) {
  //     var defaultDistrict = (right as List<DistrictEntity>).first;
  //     emit(state.copyWith(districts: right, districtPick: defaultDistrict));
  //   });
  // }

  void selectProvince(ProvinceEntity provinceEntity,
      {bool isPick = true}) async {
    final result = await agencyUseCase.getListDistrict(provinceEntity.id);
    result.fold((left) {}, (right) {
      var defaultDistrict = (right as List<DistrictEntity>).first;
      isPick
          ? emit(state.copyWith(
              districtsPickList: right, districtPick: defaultDistrict))
          : emit(state.copyWith(
              districtsDropList: right, districtDrop: defaultDistrict));
    });
    isPick
        ? emit(state.copyWith(provincePick: provinceEntity))
        : emit(state.copyWith(provinceDrop: provinceEntity));
  }

  void selectDistrict(DistrictEntity districtEntity, {bool isPick = true}) {
    isPick
        ? emit(state.copyWith(districtPick: districtEntity))
        : emit(state.copyWith(districtDrop: districtEntity));
  }
}
