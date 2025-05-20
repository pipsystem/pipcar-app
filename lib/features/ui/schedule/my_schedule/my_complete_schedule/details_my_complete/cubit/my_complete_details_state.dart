// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_complete_details_cubit.dart';

enum MyCompleteDetailsStatus { init, loading, loaded }

class MyCompleteDetailsState extends Equatable {
  final MyCompleteDetailsStatus status;
  final TicketSupplierDetails? details;
  const MyCompleteDetailsState({required this.status, required this.details});

  factory MyCompleteDetailsState.initial() =>
      const MyCompleteDetailsState(status: MyCompleteDetailsStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  MyCompleteDetailsState copyWith({
    MyCompleteDetailsStatus? status,
    TicketSupplierDetails? details,
  }) {
    return MyCompleteDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
