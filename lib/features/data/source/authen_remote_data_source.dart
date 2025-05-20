import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/exception/api_error.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/features/data/mapper/authen_mapper.dart';
import 'package:pipcar/features/domain/enterties/agency/login_entity.dart';

import '../../../common/di/di.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';
import '../models/models.dart';

abstract class AuthenRemoteDataSource {

  Future<Either<Exception, dynamic>> trackingAuth(Map<String, dynamic> params, Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> login(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> checkRT(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> updateDeviceId(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> logOut();
}

@Injectable(as: AuthenRemoteDataSource)
class AuthenRemoteDataSourceImpl extends AuthenRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> trackingAuth(Map<String, dynamic> params, Map<String, dynamic> body) {
    return call(() async {
      print(params);
      final result = await apiService.trackingAuth(params, body);
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.message;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> login(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.login(body);
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        LoginEntity loginEntity = AuthenMapper.fromLoginResoonse(loginResponse);
        return loginEntity;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> checkRT(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.checkRT(body);
      if (result.status == RemoteDataContants.successStatus) {
        final response = CheckRTResponse.fromJson(result.data);
        return response;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> logOut() {
    return call(() async {
      final result =
          await apiService.logOut("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> updateDeviceId(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.updateDeviceId(
          body, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }
}
