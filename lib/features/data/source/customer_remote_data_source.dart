import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/mixins/remote_data_source.dart';
import 'package:pipcar/features/data/mapper/customers_mapper.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';

import '../../../common/di/di.dart';
import '../../../common/exception/api_error.dart';
import '../../../common/local_storage/local_storage.dart';
import '../../../core/service/api_service/api_service.dart';
import '../models/customers/customers_response.dart';

abstract class CustomerRemoteDataSource {
  Future<Either<Exception, dynamic>> getListCustomer();
}

@Injectable(as: CustomerRemoteDataSource)
class CustomerRemoteDataSourceImpl extends CustomerRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> getListCustomer() {
    return call(() async {
      final result = await apiService
          .getListCustomer("Bearer ${LocalStorage.accessToken.val}");

      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        List<CustomersResponse> customersListResponse =
            List<CustomersResponse>.from(
                data.map((e) => CustomersResponse.fromJson(e)).toList());
        List<CustomersEntity> customers =
            CustomersMapper.fromListCustomersResponse(customersListResponse);
        return customers;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
