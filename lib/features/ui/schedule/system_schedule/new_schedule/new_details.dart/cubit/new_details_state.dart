// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'new_details_cubit.dart';

enum NewDetailsStatus { init, loading, loaded, applySuccess }

class NewDetailsState extends Equatable {
  final NewDetailsStatus status;
  final TicketSupplierDetails? details;
  const NewDetailsState({required this.status, required this.details});

  factory NewDetailsState.initial() => const NewDetailsState(status: NewDetailsStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  NewDetailsState copyWith({
    NewDetailsStatus? status,
    TicketSupplierDetails? details,
  }) {
    return NewDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
