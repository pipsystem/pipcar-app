// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'car_list_cubit.dart';

enum CarListStatus { init, loading, loaded }

class CarListState extends Equatable {
  final CarListStatus status;
  final List<CarEntity> cars;
  final CarTypeEntity selectedCarTypeAdd;
  const CarListState({
    required this.status,
    required this.cars,
    required this.selectedCarTypeAdd,
  });

  factory CarListState.initial() => CarListState(
        status: CarListStatus.init,
        cars: [],
        selectedCarTypeAdd: AppConstant.listCarType.first,
      );

  @override
  List<Object> get props => [status, cars, selectedCarTypeAdd];

  CarListState copyWith({
    CarListStatus? status,
    List<CarEntity>? cars,
    CarTypeEntity? selectedCarTypeAdd,
  }) {
    return CarListState(
      status: status ?? this.status,
      cars: cars ?? this.cars,
      selectedCarTypeAdd: selectedCarTypeAdd ?? this.selectedCarTypeAdd,
    );
  }
}
