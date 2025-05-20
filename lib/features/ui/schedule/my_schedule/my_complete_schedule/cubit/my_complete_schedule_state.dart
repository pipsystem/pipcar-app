// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_complete_schedule_cubit.dart';

enum MyCompleteScheduleStatus { loadFirst, loaded, loadMore, limit }

class MyCompleteScheduleState extends Equatable {
  final List<TicketSupplierEntity> myCompleteSchedules;
  final MyCompleteScheduleStatus status;
  const MyCompleteScheduleState({
    required this.myCompleteSchedules,
    required this.status,
  });

  factory MyCompleteScheduleState.initial() =>
      const MyCompleteScheduleState(status: MyCompleteScheduleStatus.loadFirst, myCompleteSchedules: []);

  @override
  List<Object> get props => [myCompleteSchedules, status];

  MyCompleteScheduleState copyWith({
    List<TicketSupplierEntity>? myCompleteSchedules,
    MyCompleteScheduleStatus? status,
  }) {
    return MyCompleteScheduleState(
      myCompleteSchedules: myCompleteSchedules ?? this.myCompleteSchedules,
      status: status ?? this.status,
    );
  }
}
