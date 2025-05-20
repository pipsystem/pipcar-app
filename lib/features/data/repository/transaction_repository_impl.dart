import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/domain/repository/transaction_repository.dart';

import '../source/transaction_remote_data_source.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> getListTransaction(
      Map<String, dynamic> params) async {
    final result = await remoteDataSource.getListTransaction(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsTransaction(
      {required String transactionId}) async {
    final result = await remoteDataSource.getDetailsTransaction(transactionId);
    return result;
  }
}
