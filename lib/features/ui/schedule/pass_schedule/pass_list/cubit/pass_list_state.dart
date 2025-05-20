// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pass_list_cubit.dart';

enum PassListStatus { loadFirst, loaded, loadMore, limit }

class PassListState extends Equatable {
  final List<TicketOwnerPassEntity> passList;
  final PassListStatus status;
  const PassListState({
    required this.passList,
    required this.status,
  });

  factory PassListState.initial() => const PassListState(status: PassListStatus.loadFirst, passList: []);

  @override
  List<Object> get props => [passList, status];

  PassListState copyWith({
    List<TicketOwnerPassEntity>? passList,
    PassListStatus? status,
  }) {
    return PassListState(
      passList: passList ?? this.passList,
      status: status ?? this.status,
    );
  }
}
