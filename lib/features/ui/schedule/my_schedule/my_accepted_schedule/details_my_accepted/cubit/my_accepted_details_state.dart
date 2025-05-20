// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_accepted_details_cubit.dart';

enum MyAcceptedDetailsStatus {
  init,
  loading,
  loaded,
  pickUp,
  dropOff,
  deleteNavigate
}

class MyAcceptedDetailsState extends Equatable {
  final MyAcceptedDetailsStatus status;
  final TicketSupplierDetails? details;
  const MyAcceptedDetailsState({required this.status, required this.details});

  factory MyAcceptedDetailsState.initial() => const MyAcceptedDetailsState(
      status: MyAcceptedDetailsStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  MyAcceptedDetailsState copyWith({
    MyAcceptedDetailsStatus? status,
    TicketSupplierDetails? details,
  }) {
    return MyAcceptedDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
