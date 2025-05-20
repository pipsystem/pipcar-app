// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'process_list_cubit.dart';

enum ProcessListStatus { loadFirst, loaded, loadMore, limit }

class ProcessListState extends Equatable {
  final List<TicketOwnerProcessEntity> processList;
  final ProcessListStatus status;
  const ProcessListState({
    required this.processList,
    required this.status,
  });

  factory ProcessListState.initial() =>
      const ProcessListState(status: ProcessListStatus.loadFirst, processList: []);

  @override
  List<Object> get props => [processList, status];

  ProcessListState copyWith({
    List<TicketOwnerProcessEntity>? processList,
    ProcessListStatus? status,
  }) {
    return ProcessListState(
      processList: processList ?? this.processList,
      status: status ?? this.status,
    );
  }
}
