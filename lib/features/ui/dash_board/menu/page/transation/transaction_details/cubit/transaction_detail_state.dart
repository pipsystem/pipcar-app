// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_detail_cubit.dart';

enum TransactionDetailStatus { init, loading, loaded }

class TransactionDetailState extends Equatable {
  final TransactionDetailStatus status;
  final TransactionDetailEntity? detail;

  const TransactionDetailState({required this.status, this.detail});

  factory TransactionDetailState.init() =>
      const TransactionDetailState(status: TransactionDetailStatus.init);

  @override
  List<Object?> get props => [status, detail];

  TransactionDetailState copyWith({
    TransactionDetailStatus? status,
    TransactionDetailEntity? detail,
  }) {
    return TransactionDetailState(
      status: status ?? this.status,
      detail: detail ?? this.detail,
    );
  }
}
