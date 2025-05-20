import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/authen_repository.dart';
import '../source/authen_remote_data_source.dart';

@Injectable(as: AuthenRepository)
class AuthenRepositoryImpl extends AuthenRepository {
  final AuthenRemoteDataSource remoteDataSource;

  AuthenRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> trackingAuth(Map<String, dynamic> params, Map<String, dynamic> body) async {
    final result = await remoteDataSource.trackingAuth(params, body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> login({required String phone, required String otp}) async {
    var body = {"phone": phone, "code": otp};

    final result = await remoteDataSource.login(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> checkRT({required String refreshToken}) async {
    var body = {"refresh_token": refreshToken};

    final result = await remoteDataSource.checkRT(body);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> logOut() async {
    final result = await remoteDataSource.logOut();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> updateDeviceId(Map<String, dynamic> body) async {
    final result = await remoteDataSource.updateDeviceId(body);
    return result;
  }
}
