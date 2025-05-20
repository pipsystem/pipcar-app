// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_drop_off_schedule_cubit.dart';

enum MyDropOffScheduleStatus { loadFirst, loaded, loadMore, limit, dropOff }

class MyDropOffScheduleState extends Equatable {
  final List<TicketSupplierEntity> myDropOffSchedules;
  final MyDropOffScheduleStatus status;
  const MyDropOffScheduleState({
    required this.myDropOffSchedules,
    required this.status,
  });

  factory MyDropOffScheduleState.initial() =>
      const MyDropOffScheduleState(status: MyDropOffScheduleStatus.loadFirst, myDropOffSchedules: []);

  @override
  List<Object> get props => [myDropOffSchedules, status];

  MyDropOffScheduleState copyWith({
    List<TicketSupplierEntity>? myDropOffSchedules,
    MyDropOffScheduleStatus? status,
  }) {
    return MyDropOffScheduleState(
      myDropOffSchedules: myDropOffSchedules ?? this.myDropOffSchedules,
      status: status ?? this.status,
    );
  }
}
