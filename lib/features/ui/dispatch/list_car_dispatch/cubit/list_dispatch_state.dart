// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_dispatch_cubit.dart';

enum ListDispatchStatus { init, loading, loaded, canceled, dispatchSuccess }

enum SelectCarStatus { unselect, selecting, selected}

class ListDispatchState extends Equatable {
  final ListDispatchStatus status;
  final SelectCarStatus selectCar;
  final List<DriverDeleveringEntity> driversDelevering;
  final List<DriverItemListEntity> drivers;
  final List<CarEntity> cars;
  final AnalystAgencyEntity? inforAnalyst;
  const ListDispatchState({
    required this.status,
    required this.selectCar,
    required this.driversDelevering,
    required this.drivers,
    required this.cars,
    this.inforAnalyst,
  });

  factory ListDispatchState.initial() => ListDispatchState(
      status: ListDispatchStatus.init,
      selectCar: SelectCarStatus.unselect,
      driversDelevering: const [],
      drivers: const [],
      cars: const [],
      );

  @override
  List<Object?> get props => [status, driversDelevering, drivers, inforAnalyst];

  ListDispatchState copyWith({
    ListDispatchStatus? status,
    SelectCarStatus? selectCar,
    List<DriverDeleveringEntity>? driversDelevering,
    List<DriverItemListEntity>? drivers,
    List<CarEntity>? cars,
    CarTypeEntity? selectedCarType,
    AnalystAgencyEntity? inforAnalyst,
  }) {
    return ListDispatchState(
      status: status ?? this.status,
      selectCar: selectCar ?? this.selectCar,
      driversDelevering: driversDelevering ?? this.driversDelevering,
      drivers: drivers ?? this.drivers,
      cars: cars ?? this.cars,
      // selectedCarType: selectedCarType ?? this.selectedCarType,
      inforAnalyst: inforAnalyst ?? this.inforAnalyst,
    );
  }
}
