// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_drop_off_details_cubit.dart';

enum MyDropOffDetailsStatus { init, loading, loaded, dropOff }

class MyDropOffDetailsState extends Equatable {
  final MyDropOffDetailsStatus status;
  final TicketSupplierDetails? details;
  const MyDropOffDetailsState({required this.status, required this.details});

  factory MyDropOffDetailsState.initial() =>
      const MyDropOffDetailsState(status: MyDropOffDetailsStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  MyDropOffDetailsState copyWith({
    MyDropOffDetailsStatus? status,
    TicketSupplierDetails? details,
  }) {
    return MyDropOffDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
