// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delivery_car_cubit.dart';

enum DeliveryCarStatus { init, loading, loaded }

class DeliveryCarState extends Equatable {
  final DeliveryCarStatus status;
  final List<CarEntity> cars;
  const DeliveryCarState({
    required this.status,
    required this.cars,
  });

  factory DeliveryCarState.initial() => const DeliveryCarState(
        status: DeliveryCarStatus.init,
        cars: [],
      );

  @override
  List<Object> get props => [status, cars];

  DeliveryCarState copyWith({
    DeliveryCarStatus? status,
    List<CarEntity>? cars,
  }) {
    return DeliveryCarState(
      status: status ?? this.status,
      cars: cars ?? this.cars,
    );
  }
}
