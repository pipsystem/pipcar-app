class TransactionItemEntity {
  final String transactionCoinId;
  final String ticketId;
  final int amount;
  final int type;
  final String description;
  final int newBalance;
  final String updateTime;

  TransactionItemEntity(
      {required this.transactionCoinId,
      required this.ticketId,
      required this.amount,
      required this.type,
      required this.description,
      required this.newBalance,
      required this.updateTime});
}
