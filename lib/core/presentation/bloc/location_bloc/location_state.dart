// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_cubit.dart';

enum LocationStatus { initial }

class LocationState extends Equatable {
  final LocationStatus status;
  const LocationState(
    this.status,
  );

  factory LocationState.init() => const LocationState(LocationStatus.initial);

  @override
  List<Object> get props => [status];

  LocationState copyWith({
    LocationStatus? status,
  }) {
    return LocationState(
      status ?? this.status,
    );
  }
}
