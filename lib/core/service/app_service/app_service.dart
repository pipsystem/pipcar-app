import '../../../common/local_storage/local_storage.dart';

class AppService {
  void logout() {
    LocalStorage.accessToken.val = '';
  }

  String get accessToken => LocalStorage.accessToken.val;
}
