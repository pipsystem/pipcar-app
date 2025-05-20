import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/data/source/customer_remote_data_source.dart';
import 'package:pipcar/features/domain/repository/customers_repository.dart';

@Injectable(as: CustomersRepository)
class CustomersRepositoryImpl extends CustomersRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> getListCustomers() async {
    final result = await remoteDataSource.getListCustomer();
    return result;
  }

}