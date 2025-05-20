import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';

import '../repository/authen_repository.dart';

@injectable
class AuthenUseCase {
  final AuthenRepository _repository;

  AuthenUseCase(this._repository);

  Future<Either<Exception, dynamic>> trackingAuth({String? agencyId, required String title, required String description}) async {
    final body = {
      "agency_id" : agencyId,
      "title": title,
      "description": description
    };
    final String requestBody = jsonEncode(body);
    final now = DateTime.now();
    final unixTime = now.toUtc().millisecondsSinceEpoch ~/ 1000;

    final String sign = requestBody + unixTime.toString() + AppConstant.secretKey;

    final params = {
      "sign": md5.convert(utf8.encode(sign)).toString(),
      "time": unixTime
    };

    final result = await _repository.trackingAuth(params, body);
    return result;
  }

  Future<Either<Exception, dynamic>> login({required String phone, required String otp}) async {
    final result = await _repository.login(phone: phone, otp: otp);
    return result;
  }

  Future<Either<Exception, dynamic>> checkRT({required String refreshToken}) async {
    final result = await _repository.checkRT(refreshToken: refreshToken);
    return result;
  }

  Future<Either<Exception, dynamic>> logOut() async {
    final result = await _repository.logOut();
    return result;
  }

  Future<Either<Exception, dynamic>> updateDeviceId(String deviceId) async {
    final body = {"device_id": deviceId};
    final result = await _repository.updateDeviceId(body);
    return result;
  }
}
