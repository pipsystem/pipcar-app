import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/exception/api_error.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/features/data/mapper/transaction_mapper.dart';
import 'package:pipcar/features/data/models/transaction/transaction_details_response.dart';
import 'package:pipcar/features/data/models/transaction/transaction_item_reponse.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';

import '../../../common/di/di.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';

abstract class TransactionRemoteDataSource {
  Future<Either<Exception, dynamic>> getListTransaction(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getDetailsTransaction(
      String transactionId);
}

@Injectable(as: TransactionRemoteDataSource)
class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> getListTransaction(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getListTransaction(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        var list = result.data['transaction_coin_list'] != null
            ? List<TransactionItemResponse>.from(result
                .data['transaction_coin_list']
                .map((e) => TransactionItemResponse.fromJson(e))
                .toList())
            : [];

        return List<TransactionItemEntity>.from(list
            .map((e) => TransactionMapper.convertTransactionItem(e))
            .toList());
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsTransaction(
      String transactionId) {
    return call(() async {
      final result = await apiService.getDetailsTransaction(
          transactionId, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        var data = TransactionDetailsResponse.fromJson(result.data);
        var detail = TransactionMapper.converTransactionDetail(data);
        return detail;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
