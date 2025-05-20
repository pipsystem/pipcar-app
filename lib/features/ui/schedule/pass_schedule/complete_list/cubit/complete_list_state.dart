// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'complete_list_cubit.dart';

enum CompleteListStatus { loadFirst, loaded, loadMore, limit }

class CompleteListState extends Equatable {
  final List<TicketOwnerCompleteEntity> completeList;
  final CompleteListStatus status;
  const CompleteListState({
    required this.completeList,
    required this.status,
  });

  factory CompleteListState.initial() =>
      const CompleteListState(status: CompleteListStatus.loadFirst, completeList: []);

  @override
  List<Object> get props => [completeList, status];

  CompleteListState copyWith({
    List<TicketOwnerCompleteEntity>? completeList,
    CompleteListStatus? status,
  }) {
    return CompleteListState(
      completeList: completeList ?? this.completeList,
      status: status ?? this.status,
    );
  }
}
