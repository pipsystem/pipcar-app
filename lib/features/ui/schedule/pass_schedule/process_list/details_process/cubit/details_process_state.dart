// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_process_cubit.dart';

enum DetailsProcessStatus { init, loading, loaded,cancel, completeSuccess}

class DetailsProcessState extends Equatable {
  final DetailsProcessStatus status;
  final DetailsProcessTicket? details;
  const DetailsProcessState({required this.status, required this.details});

  factory DetailsProcessState.initial() => const DetailsProcessState(status: DetailsProcessStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  DetailsProcessState copyWith({
    DetailsProcessStatus? status,
    DetailsProcessTicket? details,
  }) {
    return DetailsProcessState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
