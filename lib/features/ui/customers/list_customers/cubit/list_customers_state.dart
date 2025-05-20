// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_customers_cubit.dart';

enum ListCustomersStatus { init, loading, loaded }

class ListCustomersState extends Equatable {
  final ListCustomersStatus status;
  final List<CustomersEntity> customers;
  const ListCustomersState({
    required this.status,
    required this.customers,
  });

  factory ListCustomersState.initial() => const ListCustomersState(
    status: ListCustomersStatus.init,
    customers: [],
  );

  @override
  List<Object> get props => [status, customers];

  ListCustomersState copyWith({
    ListCustomersStatus? status,
    List<CustomersEntity>? customers,
  }) {
    return ListCustomersState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
    );
  }
}