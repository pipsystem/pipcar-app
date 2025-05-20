// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_list_cubit.dart';

enum TransactionListStatus { loadFirst, loaded, loadMore, limit }

class TransactionListState extends Equatable {
  final TransactionListStatus status;
  final List<TransactionItemEntity> transactions;
  const TransactionListState(
      {required this.status, required this.transactions});

  factory TransactionListState.initial() => const TransactionListState(
      status: TransactionListStatus.loadFirst, transactions: []);

  @override
  List<Object> get props => [status, transactions];

  TransactionListState copyWith({
    TransactionListStatus? status,
    List<TransactionItemEntity>? transactions,
  }) {
    return TransactionListState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }
}
