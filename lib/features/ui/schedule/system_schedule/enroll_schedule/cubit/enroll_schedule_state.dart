// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'enroll_schedule_cubit.dart';

enum EnrollScheduleStatus { loadFirst, loaded, loadMore, limit }

class EnrollScheduleState extends Equatable {
  final List<TicketSupplierEntity> enrollSchedules;
  final EnrollScheduleStatus status;
  const EnrollScheduleState({
    required this.enrollSchedules,
    required this.status,
  });

  factory EnrollScheduleState.initial() =>
      const EnrollScheduleState(status: EnrollScheduleStatus.loadFirst, enrollSchedules: []);

  @override
  List<Object> get props => [enrollSchedules, status];

  EnrollScheduleState copyWith({
    List<TicketSupplierEntity>? enrollSchedules,
    EnrollScheduleStatus? status,
  }) {
    return EnrollScheduleState(
      enrollSchedules: enrollSchedules ?? this.enrollSchedules,
      status: status ?? this.status,
    );
  }
}
