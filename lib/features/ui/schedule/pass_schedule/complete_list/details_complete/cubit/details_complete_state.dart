// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_complete_cubit.dart';

enum DetailsCompleteStatus { init, loading, loaded }

class DetailsCompleteState extends Equatable {
  final DetailsCompleteStatus status;
  final DetailsAcceptedTicket? details;
  const DetailsCompleteState({required this.status, required this.details});

  factory DetailsCompleteState.initial() =>
      const DetailsCompleteState(status: DetailsCompleteStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  DetailsCompleteState copyWith({
    DetailsCompleteStatus? status,
    DetailsAcceptedTicket? details,
  }) {
    return DetailsCompleteState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
