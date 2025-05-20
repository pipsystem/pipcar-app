part of 'details_driver_cubit.dart';

enum DetailsDriverStatus {init, loading,loaded}
enum LoadMarkerStatus { loading, loaded }

class DetailsDriverState extends Equatable {
  final DetailsDriverStatus status;
  final LoadMarkerStatus statusMarker;
  final DriverInfoEntity? driver;
  final List<CarEntity>? cars;
  final DriverLocationEntity? location;
  final Map<MarkerId, Marker>? markers;

  const DetailsDriverState ({
    required this.status,
    required this.statusMarker,
    this.driver,
    this.cars,
    this.location,
    this.markers
  });

  factory DetailsDriverState.init() => DetailsDriverState(
    status: DetailsDriverStatus.init,
    statusMarker: LoadMarkerStatus.loaded,
    markers: const <MarkerId, Marker>{},
  );

  @override
  List<Object?> get props => [status, driver, location, statusMarker, markers];

  DetailsDriverState copyWith ({
    DetailsDriverStatus? status,
    LoadMarkerStatus? statusMarker,
    DriverInfoEntity? driver,
    List<CarEntity>? cars,
    DriverLocationEntity? location,
    Map<MarkerId, Marker>? markers
  }) {
    return DetailsDriverState(
      status: status ?? this.status,
      statusMarker: statusMarker ?? this.statusMarker,
      driver: driver ?? this.driver,
      cars: cars ?? this.cars,
      location: location ?? this.location,
      markers: markers ?? this.markers
    );
  }
}