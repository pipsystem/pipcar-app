import 'package:either_dart/either.dart';

abstract class AuthenRepository {

  Future<Either<Exception, dynamic>> trackingAuth(Map<String, dynamic> params, Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> login({required String phone, required String otp});

  Future<Either<Exception, dynamic>> checkRT({required String refreshToken});

  Future<Either<Exception, dynamic>> updateDeviceId(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> logOut();
}
