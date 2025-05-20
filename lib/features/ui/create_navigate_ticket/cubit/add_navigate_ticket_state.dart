// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_navigate_ticket_cubit.dart';

enum AddNavigateStatus { init, createTicketSuccessful }

class AddNavigateState extends Equatable {
  final AddNavigateStatus status;
  final String? carTypeName;
  final List<ProvinceEntity> provinces;
  final List<DistrictEntity> districtsPickList;
  final List<DistrictEntity> districtsDropList;
  final ProvinceEntity? provincePick;
  final DistrictEntity? districtPick;
  final ProvinceEntity? provinceDrop;
  final DistrictEntity? districtDrop;
  const AddNavigateState({
    required this.status,
    this.carTypeName,
    this.provincePick,
    this.districtPick,
    this.provinceDrop,
    this.districtDrop,
    required this.provinces,
    required this.districtsPickList,
    required this.districtsDropList,
  });

  factory AddNavigateState.initial() => const AddNavigateState(
      status: AddNavigateStatus.init,
      districtsPickList: [],
      districtsDropList: [],
      provinces: []);

  @override
  List<Object?> get props => [
        status,
        carTypeName,
        provincePick,
        districtsPickList,
        districtsDropList,
        provinces,
        districtPick,
        districtDrop,
        provinceDrop
      ];

  AddNavigateState copyWith({
    AddNavigateStatus? status,
    String? carTypeName,
    List<ProvinceEntity>? provinces,
    List<DistrictEntity>? districtsPickList,
    List<DistrictEntity>? districtsDropList,
    ProvinceEntity? provincePick,
    DistrictEntity? districtPick,
    ProvinceEntity? provinceDrop,
    DistrictEntity? districtDrop,
  }) {
    return AddNavigateState(
      status: status ?? this.status,
      carTypeName: carTypeName ?? this.carTypeName,
      provinces: provinces ?? this.provinces,
      districtsPickList: districtsPickList ?? this.districtsPickList,
      districtsDropList: districtsDropList ?? this.districtsDropList,
      provincePick: provincePick ?? this.provincePick,
      districtPick: districtPick ?? this.districtPick,
      provinceDrop: provinceDrop ?? this.provinceDrop,
      districtDrop: districtDrop ?? this.districtDrop,
    );
  }
}
