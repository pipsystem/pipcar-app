// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_schedule_cubit.dart';

enum AddScheduleStatus { init, createTicketSuccessful, cancelOldTicketSuccessful}

class AddScheduleState extends Equatable {
  final AddScheduleStatus status;
  final String carTypeName;
  final List<ProvinceEntity> provinces;
  final ProvinceEntity? province;
  final List<DistrictEntity> districts;
  final DistrictEntity? selectedDistrict;
  const AddScheduleState({
    required this.status,
    required this.carTypeName,
    this.province,
    required this.provinces,
    required this.districts,
    this.selectedDistrict,
  });

  factory AddScheduleState.initial() => AddScheduleState(
      status: AddScheduleStatus.init,
      districts: [],
      provinces: [],
      carTypeName: AppConstant.listCarType.first.name);

  @override
  List<Object> get props => [
        status,
        carTypeName,
        province ?? "",
        districts,
        provinces,
        selectedDistrict ?? ""
      ];

  AddScheduleState copyWith({
    AddScheduleStatus? status,
    String? carTypeName,
    ProvinceEntity? province,
    List<DistrictEntity>? districts,
    List<ProvinceEntity>? provinces,
    DistrictEntity? selectedDistrict,
  }) {
    return AddScheduleState(
      status: status ?? this.status,
      carTypeName: carTypeName ?? this.carTypeName,
      province: province ?? this.province,
      districts: districts ?? this.districts,
      provinces: provinces ?? this.provinces,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
    );
  }
}
