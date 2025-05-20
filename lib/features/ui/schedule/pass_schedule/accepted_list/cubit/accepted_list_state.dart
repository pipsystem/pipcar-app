// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'accepted_list_cubit.dart';

enum AcceptedListStatus { loadFirst, loaded, loadMore, limit }

class AcceptedListState extends Equatable {
  final List<TicketOwnerAcceptedEntity> acceptedList;
  final AcceptedListStatus status;
  const AcceptedListState({
    required this.acceptedList,
    required this.status,
  });

  factory AcceptedListState.initial() =>
      const AcceptedListState(status: AcceptedListStatus.loadFirst, acceptedList: []);

  @override
  List<Object> get props => [acceptedList, status];

  AcceptedListState copyWith({
    List<TicketOwnerAcceptedEntity>? acceptedList,
    AcceptedListStatus? status,
  }) {
    return AcceptedListState(
      acceptedList: acceptedList ?? this.acceptedList,
      status: status ?? this.status,
    );
  }
}
