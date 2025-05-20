// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_enroll_details_cubit.dart';

enum MyEnrollDetailsStatus { init, loading, loaded, cancel }

class MyEnrollDetailsState extends Equatable {
  final MyEnrollDetailsStatus status;
  final TicketSupplierDetails? details;
  const MyEnrollDetailsState({required this.status, required this.details});

  factory MyEnrollDetailsState.initial() =>
      const MyEnrollDetailsState(status: MyEnrollDetailsStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  MyEnrollDetailsState copyWith({
    MyEnrollDetailsStatus? status,
    TicketSupplierDetails? details,
  }) {
    return MyEnrollDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
