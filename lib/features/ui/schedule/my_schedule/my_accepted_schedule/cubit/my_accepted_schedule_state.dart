// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_accepted_schedule_cubit.dart';

enum MyAcceptedScheduleStatus { loadFirst, loaded, loadMore, limit, dropOff }

class MyAcceptedScheduleState extends Equatable {
  final List<TicketSupplierEntity> myAcceptedSchedules;
  final MyAcceptedScheduleStatus status;
  const MyAcceptedScheduleState({
    required this.myAcceptedSchedules,
    required this.status,
  });

  factory MyAcceptedScheduleState.initial() =>
      const MyAcceptedScheduleState(status: MyAcceptedScheduleStatus.loadFirst, myAcceptedSchedules: []);

  @override
  List<Object> get props => [myAcceptedSchedules, status];

  MyAcceptedScheduleState copyWith({
    List<TicketSupplierEntity>? myAcceptedSchedules,
    MyAcceptedScheduleStatus? status,
  }) {
    return MyAcceptedScheduleState(
      myAcceptedSchedules: myAcceptedSchedules ?? this.myAcceptedSchedules,
      status: status ?? this.status,
    );
  }
}
