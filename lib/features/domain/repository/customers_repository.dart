import 'package:either_dart/either.dart';

abstract class CustomersRepository{
  Future<Either<Exception, dynamic>> getListCustomers();
}