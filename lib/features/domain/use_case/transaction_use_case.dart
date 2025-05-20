import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/features/domain/repository/transaction_repository.dart';

@injectable
class TransactionUseCase {
  final TransactionRepository _repository;

  TransactionUseCase(this._repository);

  Future<Either<Exception, dynamic>> getListTransaction(int page) async {
    var params = {'page': page, 'limit': 10};
    final result = await _repository.getListTransaction(params);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailTransaction(String id) async {
    final result = await _repository.getDetailsTransaction(transactionId: id);
    return result;
  }
}
