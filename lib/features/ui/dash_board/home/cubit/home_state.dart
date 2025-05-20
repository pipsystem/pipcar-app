// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

enum HomeStatus { init, loading, loaded }

class HomeState extends Equatable {
  final HomeStatus status;
  final AgencyInforEntity? agencyInfor;
  String? currentTicketId;
  HomeState({this.currentTicketId, required this.status, this.agencyInfor});

  factory HomeState.initial() => HomeState(status: HomeStatus.init);

  @override
  List<Object> get props => [status, agencyInfor ?? ""];

  HomeState copyWith({
    HomeStatus? status,
    AgencyInforEntity? agencyInfor,
    String? currentTicketId
  }) {
    return HomeState(
      status: status ?? this.status,
      agencyInfor: agencyInfor ?? this.agencyInfor,
      currentTicketId: currentTicketId ?? this.currentTicketId
    );
  }
}
