// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_schedule_cubit.dart';

enum NewScheduleStatus { loadFirst, loaded, loadMore, limit, applySuccess }

class NewScheduleState extends Equatable {
  final List<TicketSupplierEntity> newSchedules;
  final NewScheduleStatus status;
  const NewScheduleState({
    required this.newSchedules,
    required this.status,
  });

  factory NewScheduleState.initial() => const NewScheduleState(status: NewScheduleStatus.loadFirst, newSchedules: []);

  @override
  List<Object> get props => [newSchedules, status];

  NewScheduleState copyWith({
    List<TicketSupplierEntity>? newSchedules,
    NewScheduleStatus? status,
  }) {
    return NewScheduleState(
      newSchedules: newSchedules ?? this.newSchedules,
      status: status ?? this.status,
    );
  }
}
