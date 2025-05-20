// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_driver_cubit.dart';

enum ListDriverStatus { init, loading, loaded }

class ListDriverState extends Equatable {
  final ListDriverStatus status;
  final AgencyInforEntity? agencyInfor;
  final List<DriverItemListEntity> drivers;
  const ListDriverState({
    required this.status,
    this.agencyInfor,
    required this.drivers,
  });

  factory ListDriverState.initial() => const ListDriverState(
        status: ListDriverStatus.init,
        drivers: [],
      );

  @override
  List<Object> get props => [status, agencyInfor ?? "", drivers];

  ListDriverState copyWith({
    ListDriverStatus? status,
    AgencyInforEntity? agencyInfor,
    List<DriverItemListEntity>? drivers,
  }) {
    return ListDriverState(
      status: status ?? this.status,
      agencyInfor: agencyInfor ?? this.agencyInfor,
      drivers: drivers ?? this.drivers,
    );
  }
}
