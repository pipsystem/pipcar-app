import 'package:json_annotation/json_annotation.dart';

part 'transaction_item_reponse.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TransactionItemResponse {
  final String? transactionCoinId;
  final String? ticketId;
  final int? amount;
  final int? type;
  final String? description;
  final int? newBalance;
  final String? updateTime;

  TransactionItemResponse(
      {required this.transactionCoinId,
      required this.ticketId,
      required this.amount,
      required this.type,
      required this.description,
      required this.newBalance,
      required this.updateTime});

  factory TransactionItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemResponseToJson(this);
}
