import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/core/presentation/bloc/auth_bloc/auth_cubit.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/service/api_service/api_service.dart';

import '../../core/presentation/bloc/loading_bloc/loading_bloc.dart';
import '../../core/service/api_service/base_response/base_response.dart';
import '../di/di.dart';
import '../exception/api_error.dart';

class RemoteDataContants {
  static final String unableConnectToServer =
      translate('Unable to connect to server');
  static final String identityVerificationFailed =
      translate('Identity verification failed');
  static final String requestCanceled = translate('Request canceled');
  static final String serverError =
      translate('Your request could not be completed. Please try again.');
  static const String success = 'Success';
  static const String noData = 'No data';
  static const String message = 'message';
  static const int successStatus = 1;
  static const int errorStatus = 0;
  static const int tokenExpired = -607;
  static const int refreshTokenNull = -608;
  static const int invalidRefreshToken = -600;
  static const int statusTicketChange = -612;
}

mixin RemoteDataSource {
  Future<Either<Exception, dynamic>> call(
    Future<dynamic> Function() call, {
    bool isShowLoading = false,
  }) async {
    try {
      var hasInternet = await InternetConnectionChecker().hasConnection;
      if (!hasInternet) {
        return Left(ApiError("Mất kết nối internet!"));
      }
      if (isShowLoading) {
        getIt.get<LoadingBloc>().startLoading();
      }
      final response = await call();
      return Right(response);
    } on ExpiredTokenError catch (e) {
      return Left(e);
    } on ApiError catch (e) {
      return Left(e);
    } on SocketException catch (se) {
      return Left(ApiError(se.message));
    } on DioException catch (cl) {
      final result = await _handelDioError(cl);
      if (result is Exception) {
        return Left(result);
      } else {
        final response = await call();
        return Right(response);
      }
    } on ServerError catch (e) {
      return Left(e);
    } catch (er) {
      log("error unknow: $er");
      return Left(ApiError(RemoteDataContants.serverError));
    } finally {
      getIt.get<LoadingBloc>().finishLoading();
    }
  }

  Future _handelDioError(DioException cl) async {
    switch (cl.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(RemoteDataContants.unableConnectToServer);
      case DioExceptionType.badCertificate:
        return ApiError(RemoteDataContants.identityVerificationFailed);
      case DioExceptionType.cancel:
        return ApiError(RemoteDataContants.requestCanceled);
      default:
        if (cl.response != null) {
          final baseResponse = _processResponse(cl.response!);
          if (baseResponse.status == RemoteDataContants.tokenExpired) {
            final refreshTokenResponse =
                await TokenVerificationHandler().refreshToken();
            if (refreshTokenResponse.status ==
                    RemoteDataContants.refreshTokenNull ||
                refreshTokenResponse.status ==
                    RemoteDataContants.invalidRefreshToken) {
              getIt.get<AuthenticationCubit>().onLogout();
              return ApiError(refreshTokenResponse.message);
            }
            return refreshTokenResponse;
          } else if (baseResponse.status ==
              RemoteDataContants.refreshTokenNull) {
            getIt.get<AuthenticationCubit>().onLogout();
          } else if (baseResponse.status ==
              RemoteDataContants.statusTicketChange) {
            (getIt.get<AppRouter>().navigatorKey.currentState?.context ??
                    NavigatorState().context)
                .router
                .replaceAll([const DashBoardPageRoute()]);
          }
          return ApiError(baseResponse.message);
        } else {
          return ApiError(cl.message ?? RemoteDataContants.serverError);
        }
    }
  }

  BaseResponse _processResponse(Response response) {
    log(response.requestOptions.path);
    // if (response.statusCode == 200 || response.statusCode == 201) {
    var responseBody = response.data ?? {};
    print(responseBody);
    if (responseBody is! Map<String, dynamic>) {
      responseBody = {
        "status": 500,
        "message": "Dịch vụ đang bảo trì. Quý khách vui lòng quay lại sau"
      };
    }
    final result = BaseResponse.fromJson(responseBody);

    return result;
    // } else if (response.statusCode == 204) {
    //   return BaseResponse(status: 204, data: RemoteDataContants.noData, message: null);
    // } else if (response.statusCode == 500) {
    //   throw ApiError(RemoteDataContants.serverError);
    // } else if (response.statusCode == 401) {
    //   //người dùng chưa đăng nhập
    //   throw ApiError(RemoteDataContants.identityVerificationFailed);
    // } else {
    //   log(response.statusCode.toString());
    //   return BaseResponse.fromJson(response.data);
    // }
  }
}

class TokenVerificationHandler {
  static final TokenVerificationHandler _singleton =
      TokenVerificationHandler._internal();

  factory TokenVerificationHandler() {
    return _singleton;
  }

  TokenVerificationHandler._internal();

  final apiService = getIt.get<ApiService>();

  Future<BaseResponse> refreshToken() async {
    final refreshToken = LocalStorage.refreshToken.val;
    Map<String, dynamic> body = {
      "refresh_token": refreshToken,
    };
    if (refreshToken != "") {
      try {
        var refreshTokenResponse = await apiService.checkRT(body);
        if (refreshTokenResponse.status == RemoteDataContants.successStatus) {
          final newAccessToken = refreshTokenResponse.data['access_token'];
          LocalStorage.accessToken.val = newAccessToken;
          Logger()
              .d('Refreshed new access-token: ${LocalStorage.accessToken.val}');
          Logger().d(
              'Refreshed new refresh-token: ${LocalStorage.refreshToken.val}');
        }
        return refreshTokenResponse;
      } on DioException {
        getIt.get<AuthenticationCubit>().onLogout();
      }
    } else {
      getIt.get<AuthenticationCubit>().onLogout();
    }
    return BaseResponse(status: RemoteDataContants.refreshTokenNull);
  }
}
