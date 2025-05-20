import 'package:either_dart/either.dart';

abstract class TransactionRepository {
  Future<Either<Exception, dynamic>> getListTransaction(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsTransaction(
      {required String transactionId});
}
