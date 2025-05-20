import 'package:pipcar/features/domain/enterties/agency/login_entity.dart';

import '../models/agency/login_response.dart';

class AuthenMapper {
  static LoginEntity fromLoginResoonse(LoginResponse response) {
    return LoginEntity(
        accessToken: response.accessToken ?? "",
        refreshToken: response.refreshToken ?? "");
  }
}
