part of 'details_accepted_cubit.dart';

enum DetailsAcceptedStatus { init, loading, loaded, cancel, completeSuccess }

class DetailsAcceptedState extends Equatable {
  final DetailsAcceptedStatus status;
  final DetailsAcceptedTicket? details;
  const DetailsAcceptedState({required this.status, required this.details});

  factory DetailsAcceptedState.initial() =>
      const DetailsAcceptedState(status: DetailsAcceptedStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  DetailsAcceptedState copyWith({
    DetailsAcceptedStatus? status,
    DetailsAcceptedTicket? details,
  }) {
    return DetailsAcceptedState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
