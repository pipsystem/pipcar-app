import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../repository/customers_repository.dart';

@injectable
class CustomersUseCase {
  final CustomersRepository _repository;

  CustomersUseCase(this._repository);

  Future<Either<Exception, dynamic>> getListCustomers() async {
    final result = await _repository.getListCustomers();
    return result;
  }
}
